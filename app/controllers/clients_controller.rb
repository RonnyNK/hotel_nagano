class ClientsController < ApplicationController
  def index
    @clients = Client.all
  end

  def edit
    @client = Client.find(params[:id])
  end

  def show
    @client = Client.find(params[:id])
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        ClientMailer.welcome_email(@client).deliver

        format.html  { redirect_to(@client,
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
        format.html  { redirect_to(@client,
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
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
      format.js   { render :layout => false }
    end
  end

end
