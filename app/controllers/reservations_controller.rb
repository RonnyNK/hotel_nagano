class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.order(:date_in).all
  end

  def show
    @reservation = Reservation.find(params[:id])
    @client = @reservation.client
    @billing = @reservation.billing
    @room_names = []
    @reservation.reserved_rooms.each do |reserved_room|
      @room_names.append(reserved_room.name)
    end
  end

  def edit
    @reservation = Reservation.find(params[:id])
    @client = @reservation.client
  end

  def new
    @reservation = Reservation.new
  end

  def create
    @client = Client.find(params[:client_id])
    @reservation = @client.reservations.create(params[:reservation])
    @reserved_rooms.each do |reserved_room|
      reserved_room.reservation_id = @reservation.id
      reserved_room.save
    end
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
    @reservation.reserved_rooms.update_all(deleted_at: true)
    @reservation.destroy

    respond_to do |format|
      format.html { redirect_to reservations_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

end
