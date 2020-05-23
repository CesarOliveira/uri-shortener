require 'rails_helper'

RSpec.describe Link::Create, type: :domain do

  let!(:params) { { 'destination_url': Faker::Internet.url} }

  let!(:create_domain) do
    described_class.new(params, LinkRepository)
  end

  describe '#save' do

    subject { create_domain.save }

    context 'when shorted link is created' do
      before do
      end

      it 'should call create on LinkRepository with the right data' do
      end
    end

    context 'when an error occurs' do
      before do
      end

      it 'should return an error message ' do
      end
    end

    context 'when identifier generated is already in use for other link' do
      it 'should generate a new identifier until get a unused one' do
      end
    end
  end
end
