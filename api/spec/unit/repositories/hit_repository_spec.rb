require 'rails_helper'

RSpec.describe HitRepository, type: :repository do

  let!(:link_id) { Faker::Number.number(digits: 1)  }
  let!(:identifier) { Faker::Lorem.characters(number: 20) }

  let(:data) do
    {
      link_id: link_id,
      identifier: identifier
    }
  end

  let(:result_query) { double }
  let(:hit) { double }

  describe '.create' do
    before do
      allow(Hit).to receive(:create!).with(data)

      described_class.create(data)
    end

    it 'should call the create! method on the Hit model' do
      expect(Hit).to have_received(:create!).with(data)
    end
  end

end
