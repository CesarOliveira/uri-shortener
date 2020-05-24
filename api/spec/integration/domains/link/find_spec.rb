require 'rails_helper'

RSpec.describe Link::Find, type: :domain do

  let!(:identifier) { Faker::Lorem.characters(number: 4) }
  let!(:title) { Faker::Lorem.characters(number: 10) }

  let!(:link_repository) { double }

  let!(:create_domain) do
    described_class.new(params, link_repository)
  end

  describe '#find' do
    subject { create_domain.run }

    before do
      allow(link_repository).to receive(:find_by_identifier)
      allow(link_repository).to receive(:find_by)
    end

    context 'when find only by its identifier' do
      let!(:params) { { identifier: identifier } }

      before do
        subject
      end

      it 'should call find_by_identifier on LinkRepository with the right data' do
        expect(link_repository).to have_received(:find_by_identifier).with(identifier)
      end
    end

    context 'when find by tile and its identifier' do
      let!(:params) { { identifier: identifier, title: title } }

      before do
        subject
      end

      it 'should call find_by on LinkRepository with the right data' do
        expect(link_repository).to have_received(:find_by).with(params)
      end
    end

  end
end
