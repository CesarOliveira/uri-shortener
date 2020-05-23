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
end
