class Room < ActiveRecord::Base
  attr_accessible :base_rate_id, :floor, :name, :next_door, :room_type_id, :view_type_id
  belongs_to :base_rate
  belongs_to :room_type
  belongs_to :view_type
  has_many :reserved_rooms
  validates :base_rate_id, :floor, :name, :room_type_id, :view_type_id, presence: true
  scope :unavailable, -> {
    joins(:reserved_rooms).merge(ReservedRoom.not_deleted)
  }
  scope :available, -> {
    where('id NOT IN (?)', unavailable)
  }
end
