class BaseRate < ActiveRecord::Base
  attr_accessible :date_begin, :rate
  has_many :rooms
  validates :date_begin, :rate, presence: true
end
