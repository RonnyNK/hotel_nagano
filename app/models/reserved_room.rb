class ReservedRoom < ActiveRecord::Base
  attr_accessible :deleted_at, :reservation_id, :room_id
  belongs_to :reservation
  belongs_to :room
  validates :reservation_id, :room_id, presence: true
end
