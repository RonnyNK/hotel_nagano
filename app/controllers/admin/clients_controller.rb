class Admin::ClientsController < ApplicationController
  def index
    @clients = Client.not_deleted
  end

  def edit
    @client = Client.find(params[:id])
  end

  def show
    @client = Client.find(params[:id])
    @reservations = @client.reservations
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        ClientMailer.welcome_email(@client).deliver

        format.html  { redirect_to([:admin, @client],
                                   :notice => 'Client was successfully created.') }
        format.json  { render :json => @client,
                              :status => :created, :location => @client }
      else
        format.html  { render :action => "new" }
        format.json  { render :json => @client.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html  { redirect_to([:admin, @client],
                                   :notice => 'Client was successfully updated.') }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json => @client.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @client = Client.find(params[:id])
    @client.update_attribute(:deleted_at, Date.current)
    @client.reservations.update_all(deleted_at: Date.current)
    @client.reserved_rooms.update_all(deleted_at: Date.current)

    respond_to do |format|
      format.html { redirect_to admin_clients_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

end
