class DayRate < ActiveRecord::Base
  attr_accessible :name, :rate
  validates :name, :rate, presence: true
end
