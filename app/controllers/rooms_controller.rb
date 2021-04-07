class RoomsController < ApplicationController
  def index
    if params[:date_in].present? && params[:date_out].present?
      date_in = params[:date_in]
      date_out = params[:date_out]
      @rooms = Room.no_overlap(date_in, date_out)
      if @rooms.empty?
        @rooms = Room.all
      end
    else
      @rooms = Room.available
    end
  end

  def search

  end

end
