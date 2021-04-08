class ReservedRoomsController < ApplicationController
  def index
    @reserved_rooms = ReservedRoom.not_deleted
  end

  def destroy
    @reserved_room = ReservedRoom.find(params[:id])
    @reserved_room.update_attribute(:deleted_at, Date.current)
    redirect_to reserved_rooms_path
  end
end
