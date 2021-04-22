class ReservedRoom < ActiveRecord::Base
  attr_accessible :deleted_at, :reservation_id, :room_id
  belongs_to :reservation
  belongs_to :room
  validates :reservation_id, :room_id, presence: true
  scope :not_deleted, -> {
    where(deleted_at: nil)
  }
  scope :deleted, -> {
    where('deleted_at IS NOT NULL')
  }
  scope :overlap, ->(date_in, date_out) {
    joins(:reservation).merge(Reservation.overlap(date_in, date_out))
  }
  def name
    self.room.name
  end
end
