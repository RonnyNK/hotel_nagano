class Statistics < ActiveRecord::Base
  def self.calculate_today
    reservations = Reservation.today
    rooms = []
    reservations.each do |reservation|
      reserved_rooms = reservation.reserved_rooms
      reserved_rooms.each do |reserved_room|
        rooms.append(Room.find(reserved_room.room_id))
      end
    end
    rooms
  end

  def self.occupancy_ratio
    total_rooms = (Room.all.length).to_f
    occupied_rooms = calculate_today
    (occupied_rooms.length).to_f / total_rooms
  end
end
