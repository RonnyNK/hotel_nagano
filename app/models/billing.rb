class Billing < ActiveRecord::Base
  attr_accessible :total_amount
  has_one :reservation

  def self.applied_special_rates(date_in, date_out)
    applied_day_rates = DayRate.applied_rates(date_in, date_out)
    applied_season_rates = SeasonRate.applied_rates(date_in, date_out)

    applied_day_rates.zip(applied_season_rates).map { |x, y| x + y }
  end

  def self.calculate_total
    clients = Client.all

    clients.each do |client|
      reservations = client.reservations
      reservations.each do |reservation|
        total_amount = self.calculate(reservation)
        self.create(total_amount: total_amount)
      end
    end
  end

  def self.calculate_room(reserved_room)
    reservation = reserved_room.reservation
    occurence_of_rate = [reserved_room.rate] * reservation.duration
    applied_special_rates = applied_special_rates(reservation.date_in, reservation.date_out)

    total = occurence_of_rate.zip(applied_special_rates).map{|x,y| x * y}
    total_amount = occurence_of_rate.zip(total).map {|x,y| x + y}.sum
  end

  def self.calculate(reservation)
    total_amount = 0
    reserved_rooms = reservation.reserved_rooms

    reserved_rooms.each do |reserved_room|
      total_amount += self.calculate_room(reserved_room)
    end

    self.create(total_amount: total_amount)
    reservation.update_attribute(:billing_id, Billing.last.id)
    reservation.billing.total_amount
  end
end
