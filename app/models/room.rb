class Room < ApplicationRecord
  belongs_to :log_file
  has_many :visits
  has_many :visitors, through: :visits
end
