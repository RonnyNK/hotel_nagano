class Admin::StatisticsController < ApplicationController
  def index
    @rooms = Statistics.calculate_today
    @occupancy_rate = (Statistics.occupancy_ratio * 100).round(2)
  end
end
