class ReservedRoom < ActiveRecord::Base
  attr_accessible :deleted_at, :reserving, :reservation_id, :room_id
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
  scope :unavailable_today, -> {
    where(deleted_at: nil).joins(:reservation).merge(Reservation.today)
  }
  scope :available_today, -> {
    where("reserved_rooms.id NOT IN (?)", unavailable_today)
  }
  def name
    self.room.name
  end
  def rate
    self.room.base_rate.rate
  end
end
