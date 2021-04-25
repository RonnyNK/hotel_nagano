class ReservedRoomsController < ApplicationController
  def index
    if params[:date_in].present? && params[:date_out].present?
      date_in = params[:date_in]
      date_out = params[:date_out]

      @rooms_searched = Room.no_overlap(date_in, date_out)

      if @rooms_searched.empty?
        @rooms_searched = Room.all
      end

      if params[:view_type_id].present?
        @rooms_searched = @rooms_searched.select {|room| (room.view_type_id).to_s == params[:view_type_id]}
      end

      if params[:room_type_id].present?
        @rooms_searched = @rooms_searched.select {|room| (room.room_type_id).to_s == params[:room_type_id]}
      end

    else
      @rooms = Room.not_deleted
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @client = Client.find(params[:client_id])
    date_in = params[:date_in]
    date_out = params[:date_out]
    @reservation = @client.reservations.new(date_in: date_in, date_out: date_out)
    @reserved_rooms = []
    params[:room_ids].each do |room_id|
      reserved_room = ReservedRoom.new
      reserved_room.room_id = room_id
      reserved_room.reservation_id = @reservation.id
      @reserved_rooms.append(reserved_room)
    end
    @rooms = []
    @reserved_rooms.each do |reserved_room|
      @rooms.append(reserved_room.room)
    end
  end

  def create
    @client = Client.find(params[:client_id])
    date_in = params[:date_in]
    date_out = params[:date_out]
    demands = params[:demands]
    @reservation = @client.reservations.create(date_in: date_in, date_out: date_out, demands: demands)
    room_ids = params[:room_ids]
    room_ids.each do |room_id|
      ReservedRoom.create(room_id: room_id, reservation_id: @reservation.id)
    end
    ClientMailer.billing_reservation(@client).deliver
    redirect_to client_path(@client)
  end

  def destroy
    @reserved_room = ReservedRoom.find(params[:id])
    @reserved_room.update_attribute(:deleted_at, Date.current)
    redirect_to reserved_rooms_path
  end
end
