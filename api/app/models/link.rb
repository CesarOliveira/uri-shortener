class Link < ApplicationRecord
  has_many :hits
  validates :destination_url, presence: true

  scope :count_hits, -> do
    query = "
      SELECT
        lk.id,
        lk.title,
        lk.identifier,
        lk.destination_url,
        (SELECT COUNT(*) FROM hits ht WHERE ht.link_id = lk.id) as total_hits,
        (SELECT COUNT(DISTINCT ht.identifier) FROM hits ht WHERE ht.link_id = lk.id) as unique_hits
      FROM links lk
      ORDER BY total_hits DESC"

    Link.find_by_sql(query)
  end
end
