class Room < ActiveRecord::Base
  attr_accessible :base_rate_id, :deleted_at, :floor, :name, :next_door, :room_type_id, :view_type_id
  belongs_to :base_rate
  belongs_to :room_type
  belongs_to :view_type
  has_many :reserved_rooms
  validates :base_rate_id, :floor, :name, :room_type_id, :view_type_id, presence: true
  scope :not_deleted, -> {
    where(deleted_at: nil)
  }
  scope :unavailable, -> {
    joins(:reserved_rooms).merge(ReservedRoom.not_deleted)
  }
  scope :available, -> {
    where('id NOT IN (?)', unavailable)
  }
  scope :overlap, ->(date_in, date_out) {
    joins(:reserved_rooms).merge(ReservedRoom.overlap(date_in, date_out))
  }
  scope :no_overlap, ->(date_in, date_out) {
    where('id NOT IN (?)', overlap(date_in, date_out))
  }
  scope :by_view, ->(view_type_id) {
    where('view_type_id IS ?', view_type_id)
  }
  scope :unavailable_today, -> {
    joins(:reserved_rooms).merge(ReservedRoom.unavailable_today)
  }
  scope :available_today, -> {
    where('id NOT IN (?)', unavailable_today)
  }
  def rate
    self.base_rate.rate
  end
end
