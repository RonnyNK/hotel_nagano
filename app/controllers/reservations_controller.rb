class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(:date_in).all
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def edit
    @reservation = Reservation.find(params[:id])
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @client = Client.find(params[:client_id])
    @reservation = @client.reservations.create(params[:reservation])
    redirect_to client_path(@client)
  end

  def update
    @reservation = Reservation.find(params[:id])

    respond_to do |format|
      if @reservation.update_attributes(params[:reservation])
        format.html  { redirect_to(@reservation,
                                   :notice => 'Reservation was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @reservation.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_url
  end

end
