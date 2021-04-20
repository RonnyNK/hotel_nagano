class Billing < ActiveRecord::Base
  attr_accessible :total_amount
  has_one :reservation

  def self.applied_special_rates(date_in, date_out)
    applied_day_rates = DayRate.applied_rates(date_in, date_out)
    applied_season_rates = SeasonRate.applied_rates(date_in, date_out)

    applied_day_rates.zip(applied_season_rates).map { |x, y| x + y }
  end

=begin
  def self.calculate_total
    reserved_room_list = ReservedRoom.joins(:room).scoped

    reserved_room_list.each { |reserved_room|
      reservation = reserved_room.reservation
      date_in = reservation.date_in
      date_out = reservation.date_out
      number_of_days = (date_out - date_in).to_i + 1
      room_rate = reserved_room.room.base_rate.rate
      occurence_of_rate = [room_rate] * number_of_days

      applied_special_rates = applied_special_rates(date_in, date_out)
      total = occurence_of_rate.zip(applied_special_rates).map { |x, y| x * y }
      total_amount = (occurence_of_rate.zip(total).map { |x, y| x + y }).sum

      self.create(total_amount: total_amount)
    }
  end
=end

  def self.calculate(reservation)
    total_amount = 0
    reserved_rooms = reservation.reserved_rooms
    date_in = reservation.date_in
    date_out = reservation.date_out
    number_of_days = (date_out - date_in).to_i + 1

    reserved_rooms.each do |reserved_room|
      room_rate = reserved_room.room.base_rate.rate
      occurence_of_rate = [room_rate] * number_of_days

      applied_special_rates = applied_special_rates(date_in, date_out)
      total = occurence_of_rate.zip(applied_special_rates).map { |x, y| x * y }
      total_amount += (occurence_of_rate.zip(total).map { |x, y| x + y }).sum
    end
    self.create(total_amount: total_amount)
    reservation.update_attribute(:billing_id, Billing.last.id)
    reservation.billing.total_amount
  end
end
