require 'rails_helper'

RSpec.describe LinkRepository, type: :repository do
  let(:data) do
    {
      destination_url: Faker::Number.number(digits: 1)
    }
  end

  let(:result_query) { double }
  let(:link) { double }

  describe '.create' do
    before do
      allow(Link).to receive(:create!).with(data)

      described_class.create(data)
    end

    it 'should call the create! method on the Link model' do
      expect(Link).to have_received(:create!).with(data)
    end
  end
end
