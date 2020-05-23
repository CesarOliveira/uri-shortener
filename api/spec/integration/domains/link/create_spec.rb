require 'rails_helper'

RSpec.describe Link::Create, type: :domain do
  let!(:params) { { 'destination_url': Faker::Internet.url } }
  let!(:link_repository) { double }
  let!(:identifier) { Faker::Lorem.characters(number: 4) }

  let!(:initial_size_of_identifier) { ENV['INITIAL_SIZE_OF_HASH'].to_i }

  let!(:create_domain) do
    described_class.new(params, link_repository)
  end

  describe '#save' do

    subject { create_domain.save }

    before do
      allow(SecureRandom).to receive(:alphanumeric).with(initial_size_of_identifier).and_return(identifier)
      allow(link_repository).to receive(:create)
      allow(link_repository).to receive(:find_by)
    end

    context 'when shorted link is created' do

      let!(:data) { params.merge(identifier: identifier) }

      before do
        subject
      end

      it 'should call create on LinkRepository with the right data' do
        expect(link_repository).to have_received(:create).with(data)
      end
    end

    context 'when an error occurs' do
      let(:error_message) { Faker::Lorem.word }

      before do
        allow(link_repository).to receive(:create).and_raise(StandardError, error_message)
      end

      it 'should return an error message ' do
        is_expected.to eq({ errors: error_message })
      end
    end

    context 'when identifier generated is already in use for other link' do
      let!(:other_identifier) { Faker::Lorem.characters(number: 5) }
      let!(:increased_size_of_identifier) { initial_size_of_identifier + 1 }
      let!(:data) { params.merge(identifier: other_identifier) }

      before do
        allow(link_repository).to receive(:find_by).with(identifier: identifier).and_return(true)
        allow(link_repository).to receive(:find_by).with(identifier: other_identifier).and_return(false)
        allow(SecureRandom).to receive(:alphanumeric)
          .with(increased_size_of_identifier).and_return(other_identifier)
        subject
      end

      it 'should generate a new identifier until get a unused one and create the shorted link' do
        expect(link_repository).to have_received(:create).with(data)
      end
    end
  end
end
