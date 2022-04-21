class Distance < ApplicationRecord
  belongs_to :user
  validates :source_location, :destination_location, presence: true
end
