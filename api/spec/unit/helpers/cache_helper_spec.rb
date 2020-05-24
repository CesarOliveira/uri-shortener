require 'rails_helper'

RSpec.describe CacheHelper, type: :helper do
  describe '#connected?' do
    let!(:redis) { double }
    let!(:cache) { double }

    before do
      allow(Rails).to receive(:cache).and_return(cache)
      allow(cache).to receive(:redis).and_return(redis)
    end

    subject { connected? }

    context 'when redis is connected' do
      before do
        allow(redis).to receive(:connected?).and_return(true)
      end

      it 'should return true' do
          is_expected.to eq(true)
      end
    end

    context 'when redis is not connected' do

      before do
        allow(redis).to receive(:connected?).and_return(false)
        allow(redis).to receive(:ping).and_return(false)
      end

      it 'should try to ping redis' do
        is_expected.to eq(false)
      end
    end
  end
end
