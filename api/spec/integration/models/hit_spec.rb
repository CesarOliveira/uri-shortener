require 'rails_helper'

RSpec.describe Hit, type: :model do

  let!(:hit) { Hit.new }

  describe 'fields' do
    it do
      is_expected.to have_db_column(:id).of_type(:integer)
      is_expected.to have_db_column(:identifier).of_type(:string)
      is_expected.to have_db_column(:link_id).of_type(:integer)
      is_expected.to have_db_column(:created_at).of_type(:datetime)
      is_expected.to have_db_column(:updated_at).of_type(:datetime)
    end
  end

  describe 'associations' do
    it 'should validate if it belong to link' do
      expect(hit).to belong_to :link
    end
  end
end
