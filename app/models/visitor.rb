class Visitor < ApplicationRecord
  belongs_to :log_file
  has_many :visits
  has_many :rooms, through: :visits

  def self.create_entry(log_file_id, visitor_id, visitor_hash)
    self.create(visitor_id: visitor_id,
                room_visits: visitor_hash[:room_count],
                average_stay: visitor_hash[:average_stay],
                log_file_id: log_file_id
    )
  end
end
