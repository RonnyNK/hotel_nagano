class Admin::StatisticsController < ApplicationController
  def index
    @reserved_rooms = Statistics.calculate_today
    @rooms = @reserved_rooms.map{|reserved_room| Room.find(reserved_room.room_id)}

    @occupancy_rate = Statistics.occupancy_ratio * 100
    @revenue = Statistics.revenue
  end
end
