class SeasonRate < ActiveRecord::Base
  attr_accessible :from_date, :name, :rate, :to_date
  validates :from_date, :name, :rate, :to_date, presence: true
  scope :between_dates, ->(date) { where("? BETWEEN from_date AND to_date", date) }

  def self.applied_rates(date_begin, date_end)
    applicable = []
    date = date_begin

    while date <= date_end
      total_day_rate = self.between_dates(date).pluck(:rate).sum
      applicable.append(total_day_rate)
      date = date + 1
    end

    applicable
  end
end
