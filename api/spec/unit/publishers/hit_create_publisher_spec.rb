require 'rails_helper'

RSpec.describe HitCreatePublisher, type: :publishers do
  let!(:link_id) { Faker::Number.number(digits: 1) }
  let!(:identifier) { Faker::Lorem.characters(number: 20) }

  let!(:data) do
    {
      link_id: link_id,
      identifier: identifier
    }
  end

  before do
    allow(Hutch).to receive(:connect)
    allow(Hutch).to receive(:publish)
  end

  describe '.run' do
    before do
      described_class.run(link_id, identifier)
    end

    it 'connect in hutch' do
      expect(Hutch).to have_received(:connect)
    end

    it 'publish in queue' do
      expect(Hutch).to(
        have_received(:publish).with('hit.create', subject: data)
      )
    end
  end
end
