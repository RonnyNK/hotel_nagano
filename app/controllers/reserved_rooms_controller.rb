class ReservedRoomsController < ApplicationController
  def index
    @reserved_rooms = ReservedRoom.not_deleted
  end
end
