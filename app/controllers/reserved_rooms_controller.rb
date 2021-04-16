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
      @rooms = Room.available
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    @reserved_room = ReservedRoom.find(params[:id])
    @reserved_room.update_attribute(:deleted_at, Date.current)
    redirect_to reserved_rooms_path
  end
end
