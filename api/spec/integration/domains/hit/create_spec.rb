require 'rails_helper'

RSpec.describe Hit::Create, type: :domain do

  let!(:link) { create(:link)  }
  let!(:identifier) { Faker::Lorem.characters(number: 20) }

  let!(:params) do
    {
      link_id: link.id,
      identifier: identifier
    }
  end

  let!(:hit_repository) { double }

  let!(:create_domain) do
    described_class.new(params, hit_repository)
  end

  describe '#save' do

    subject { create_domain.save }

    before do
      allow(hit_repository).to receive(:create)
    end

    context 'when shorted link is created' do

      before do
        subject
      end

      it 'should call create on HitRepository with the right data' do
        expect(hit_repository).to have_received(:create).with(params)
      end
    end

    context 'when an error occurs' do
      let(:error_message) { Faker::Lorem.word }

      before do
        allow(hit_repository).to receive(:create).and_raise(StandardError, error_message)
      end

      it 'should return an error message ' do
        is_expected.to eq({ errors: error_message })
      end
    end
  end
end
