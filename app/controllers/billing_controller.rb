class BillingController < ApplicationController
  def show
    @reservation = Reservation.find(params[:id])
    @billing = @reservation.billing
    @client = @reservation.client
  end
end
