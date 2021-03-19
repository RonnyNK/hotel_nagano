class SeasonRate < ActiveRecord::Base
  attr_accessible :from_date, :name, :rate, :to_date
  validates :from_date, :name, :rate, :to_date, presence: true
end
