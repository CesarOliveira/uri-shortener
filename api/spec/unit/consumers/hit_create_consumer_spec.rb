require 'rails_helper'

RSpec.describe HitCreateConsumer, type: :consumers do
  let!(:link_id) { Faker::Number.number(digits: 1) }
  let!(:identifier) { Faker::Lorem.characters(number: 20) }

  let!(:subject) do
    {
      link_id: link_id,
      identifier: identifier
    }.stringify_keys
  end

  let(:message) do
    double(
      body: {
        subject: subject
      }
    )
  end

  describe '.process' do
    let(:stub_create_hit) { double }

    before do
      allow(stub_create_hit).to receive(:save)
      allow(Hit::Create).to receive(:new).and_return(stub_create_hit)

      described_class.new.process(message)
    end

    it 'call the new method in Hit::Create domain' do
      expect(Hit::Create).to have_received(:new).with(
        subject.symbolize_keys,
        HitRepository
      )
    end

    it 'call the save method in Hit::Create domain' do
      expect(stub_create_hit).to have_received(:save)
    end
  end
end
