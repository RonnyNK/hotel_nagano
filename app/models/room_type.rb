class RoomType < ActiveRecord::Base
  attr_accessible :name
  has_many :rooms
  validates :name, presence: true
end
