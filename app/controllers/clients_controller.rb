class ClientsController < ApplicationController
  
  # load_and_authorize_resource
  before_action :set_client, only: %i[ show edit update destroy ]
  
  def index
    @clients = Client.all
    render "shared/not_found"  if @clients.blank?
  end
  
  def show
  end

  def new
    @client = Client.new
  end

  def update
    if @client.update client_params
      redirect_to client_url(@client), notice: "Client was successfully updated."
    else
      render :edit
    end
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to client_url(@client), notice: "Client was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @client.destroy
    redirect_to clients_url, notice: "Client was successfully destroyed."
  end
  
  private
    def set_client
      @client =  Client.find(params[:id])
    end

    def client_params
      params.require(:client).permit(
        :first_name, 
        :second_name, 
        :patronymic, 
        :email, 
        :phone_number, 
        :additional_phone_number,
        :adress
      )
    end
end
