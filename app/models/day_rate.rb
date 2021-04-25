class DayRate < ActiveRecord::Base
  attr_accessible :name, :rate
  validates :name, :rate, presence: true
  def self.applied_rates(date_begin, date_end)
    applicable = []
    date = date_begin

    while date <= date_end
      applicable.append(self.where(name: date.strftime("%A")).pluck(:rate)[0])
      date = date + 1
    end

    applicable
  end
  def self.applied(date_begin, date_end)
    applied = []
    date = date_begin

    while date <= date_end
      applied.append(self.where(name: date.strftime("%A")))
      date = date + 1
    end

    applied
  end
end
