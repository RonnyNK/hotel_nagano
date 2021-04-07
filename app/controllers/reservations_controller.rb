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
    @reservation = Reservation.new
  end

  def create
    @client = Client.find(params[:client_id])
    @reservation = @client.reservations.create(params[:reservation])
    redirect_to client_path(@client)
  end
end
