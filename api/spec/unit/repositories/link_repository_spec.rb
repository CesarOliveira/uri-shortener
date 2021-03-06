require 'rails_helper'

RSpec.describe LinkRepository, type: :repository do
  let(:data) do
    {
      destination_url: Faker::Internet.url
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

  describe '.find_by' do
    before do
      allow(Link).to receive(:find_by).with(data)

      described_class.find_by(data)
    end

    it 'should call the find_by method on the Link model' do
      expect(Link).to have_received(:find_by).with(data)
    end
  end

  describe '.update' do
    before do
      allow(link).to receive(:update)
      described_class.update(link, data)
    end

    it 'should call the update method on the Link model' do
      expect(link).to have_received(:update).with(data)
    end
  end

  describe '.find' do
    let!(:id) { Faker::Lorem.characters(number: 4) }

    before do
      allow(Link).to receive(:find)

      described_class.find(id)
    end

    it 'should call the find method on the Link model with the right data' do
      expect(Link).to have_received(:find).with(id)
    end
  end

  describe '.find_by_identifier' do

    let!(:identifier) { Faker::Lorem.characters(number: 4) }
    let!(:data) { { identifier: identifier } }

    before do
      allow(CacheHelper).to receive(:connected?).and_return(false)
      allow(Link).to receive(:find_by).with(data)

      described_class.find_by_identifier(identifier)
    end

    it 'should call the identifier method on the Link model with the right data' do
      expect(Link).to have_received(:find_by).with(data)
    end
  end
end
