class ClientsController < ApplicationController
  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  def edit
  end

  def show
  end

  def new
  end

end
