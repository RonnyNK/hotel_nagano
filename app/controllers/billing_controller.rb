class BillingController < ApplicationController
  def show
    @reservation = Reservation.find(params[:id])
    @billing = @reservation.billing
    @client = @reservation.client
    date_in = @reservation.date_in
    date_out = @reservation.date_out
    @applied_days = DayRate.applied(date_in, date_out)
    @applied_seasons = SeasonRate.applied(date_in, date_out)
    @reserved_rooms = @reservation.reserved_rooms
  end
end
