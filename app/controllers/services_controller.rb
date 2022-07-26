class ServicesController < ApplicationController
  
  before_action :set_service, only: %i[ show edit update destroy ]
  
  def index
    @services = Service.all
  end
  
  def show
  end

  def new
    @service = Service.new
  end

  def update
    if @service.update permitted_service_params
      redirect_to service_url(@service), notice: "Service was successfully updated."
    else
      render :edit
    end
  end

  def create
    @service = Service.new(permitted_service_params)

    if @service.save
      redirect_to service_url(@service), notice: "Service was successfully created."
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @service.destroy
    redirect_to services_url, notice: "Service was successfully destroyed."
  end
  
  private
    def set_service
      @service =  Service.find(params[:id])
    end

    def permitted_service_params
      params[:service].permit(:name, :order_id, :price)
    end
  
end
