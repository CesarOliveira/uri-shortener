require 'rails_helper'

RSpec.describe LinkSetTitleConsumer, type: :consumers do

  let!(:link) { double}
  let!(:title) { Faker::TvShows::GameOfThrones.house }

  let!(:link_id) { Faker::Number.number(digits: 1) }

  let(:message) do
    {
        link_id: link_id
    }
  end

  describe '.process' do
    let(:stub_create_hit) { double }

    before do
      allow(LinkRepository).to receive(:find).and_return(link)
      allow(LinkRepository).to receive(:update)

      allow(Crawler).to receive(:get_title).and_return(title)
      allow(link).to receive(:destination_url)

      described_class.new.process(message)
    end

    it 'call the update method in LinkRepository' do
      expect(LinkRepository).to have_received(:update).with(
        link,
        title: title
      )
    end
  end
end
