class Link < ApplicationRecord
  has_many :hits
  validates :destination_url, presence: true
end
