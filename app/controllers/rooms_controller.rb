class RoomsController < ApplicationController
  def index
    @rooms = Room.all
  end

  def edit
    @room = Room.find(params[:id])
  end

  def show
    @room = Room.find(params[:id])
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(params[:room])

    respond_to do |format|
      if @room.save
        format.html  { redirect_to(@room,
                                   :notice => 'Room was successfully created.') }
        format.json  { render :json => @room,
                              :status => :created, :location => @room }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @room.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def update
    @room = Room.find(params[:id])

    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html  { redirect_to(@room,
                                   :notice => 'Room was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @room.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_url
  end

end
