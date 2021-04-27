class Statistics < ActiveRecord::Base
  def self.calculate_today
    reservations = Reservation.today
    rooms = []
    reservations.each do |reservation|
      reserved_rooms = reservation.reserved_rooms
      reserved_rooms.each do |reserved_room|
        rooms.append(reserved_room)
      end
    end
    rooms
  end

  def self.occupancy_ratio
    total_rooms = (Room.not_deleted.length).to_f
    occupied_rooms = calculate_today
    (occupied_rooms.length).to_f / total_rooms
  end

  def self.revenue
    revenue = 0
    occupied_rooms = calculate_today
    occupied_rooms.each do |room|
      revenue += Billing.calculate_room_date(room, Date.current)
    end

    revenue
  end
end
