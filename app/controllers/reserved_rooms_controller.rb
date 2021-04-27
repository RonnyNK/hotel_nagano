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

      if params[:nb_rooms].present?
        if params[:nb_rooms].to_i > @rooms_searched.length
          @rooms_searched = nil
        end
      end
      @contiguous = []
      if params[:contiguous].present?

        @rooms_searched.each do |room|
          if room.next_door.present?
            @contiguous.append([room, Room.find(room.next_door)])
          end
        end
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

    reservings = @client.reservations.reservings
    reservings.each do |reserving|
      reserving.destroy
    end

    date_in = params[:date_in]
    date_out = params[:date_out]
    @reservation = @client.reservations.new(date_in: date_in, date_out: date_out, reserving: true)
    @reservation.save

    @reserved_rooms = []
    params[:room_ids].each do |room_id|
      reserved_room = ReservedRoom.new
      reserved_room.room_id = room_id
      reserved_room.reservation_id = @reservation.id
      reserved_room.save
      @reserved_rooms.append(reserved_room)
    end
    @rooms = []
    @reserved_rooms.each do |reserved_room|
      @rooms.append(reserved_room.room)
    end
  end

  def create
    @client = Client.find(params[:client_id])

    reservation = @client.reservations.last
    reservation.reserving = false
    reservation.demands = params[:demands]
    reservation.save

    reserved_rooms = reservation.reserved_rooms
    reserved_rooms.each do |reserved_room|
      reserved_room.destroy
    end

    @reserved_rooms = []
    params[:room_ids].each do |room_id|
      reserved_room = ReservedRoom.new
      reserved_room.room_id = room_id
      reserved_room.reservation_id = reservation.id
      reserved_room.save
      @reserved_rooms.append(reserved_room)
    end

    @reserved_rooms.each do |reserved_room|
      reserved_room.priced_at = Billing.calculate_room(reserved_room)
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
