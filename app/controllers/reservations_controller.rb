class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(:date_in).all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
  end

  def new
  end
end
