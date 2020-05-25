require 'rails_helper'

RSpec.describe 'Links', type: :request do
  describe 'Resquest to create new link' do

    let(:data) do
      {
        "link": {
            "destination_url": Faker::Internet.url
        }
      }
    end

    context 'when send with the right data' do

      before do
        post '/api/links', params: data
      end

      it 'must return status created' do
        expect(response).to have_http_status(:created)
      end

      it 'must match json schema' do
        expect(response).to match_json_schema('links/create')
      end

    end

    context 'when send with the wrong data' do

      before do
        data[:link][:destination_url] = ''
        post '/api/links', params: data
      end

      it 'must return status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must match json data error message' do
        parsed_response = JSON.parse(response.body)
        expect(parsed_response['errors']).to include("Validation failed: Destination url can't be blank")
      end
    end

    context 'when an error occurs during save' do
      let(:error_message) { Faker::Lorem.word }

      before do
        allow(Link::Create).to receive(:new).and_raise(StandardError, error_message)
        post '/api/links', params: data
      end

      it 'must return status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must match json data error message' do
        expect(JSON.parse(response.body)['errors']).to eq(error_message)
      end
    end
  end

  describe 'Resquest to redirect a shorted link' do

    let!(:link) { create(:link, id: 1, identifier: '1234') }
    let(:date) { Time.new(3019, 11, 26, 14, 35, 0) }

    let!(:data) do
      {
        link_id: link.id,
        identifier: '8fb6ec35da080cc20febbc79a28cedc3'
      }
    end

    let!(:secure_random) { '9fcf91615164273cff702d4c' }

    before do
      allow(CacheHelper).to receive(:connected?).and_return(false)
      allow(Hutch).to receive(:connect)
      allow(Hutch).to receive(:publish)
      allow(Time).to receive(:now).and_return(date)
      allow(SecureRandom).to receive(:hex).and_return(secure_random)
    end

    context 'when the shorted link exists' do
      before do
        get "/#{link.identifier}"
      end

      it 'must return status found and redirect' do
        expect(response).to have_http_status(:found)
      end

      it 'must return status found and redirect' do
        expect(response).to redirect_to(link.destination_url)
      end


      it 'should connect in hutch' do
        expect(Hutch).to have_received(:connect)
      end

      it 'should publish in queue to process the hit' do
        expect(Hutch).to(
          have_received(:publish).with('hit.create', subject: data)
        )
      end
    end

    context 'when the shorted link does not exists' do
      let!(:fake_identifier) { Faker::Lorem.characters(number: 10) }

      before do
        get "/#{fake_identifier}"
      end

      it 'must return status not_found' do
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when an error occurs during redirect' do
      let(:error_message) { Faker::Lorem.word }

      before do
        allow(Link::Find).to receive(:new).and_raise(StandardError, error_message)
        get "/#{link.identifier}"
      end

      it 'must return status unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'must match json data error message' do
        expect(JSON.parse(response.body)['errors']).to eq(error_message)
      end
    end
  end
end
