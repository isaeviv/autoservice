class SpecialistsController < ApplicationController
  
  # load_and_authorize_resource
  before_action :set_specialist, only: %i[ show edit update destroy ]
  
  def index
    @specialists = Specialist.all
  end

  def show
  end

  def new
    @specialist = Specialist.new
  end
  
  def edit
  end

  def update
    if @specialist.update permitted_specialist_params
      redirect_to specialists_path, notice: "specialist was successfully updated."
    else
      render :edit
    end
  end

  def create
    @specialist = Specialist.new(permitted_specialist_params)

    if @specialist.save
      redirect_to specialists_path, notice: "specialist was successfully created."
    else
      render :new
    end
  end

  def destroy
    @specialist.destroy
    redirect_to specialists_url, notice: "specialist was successfully destroyed."
  end
  
  private
    def set_specialist
      @specialist =  Specialist.find(params[:id])
    end

    def permitted_specialist_params
      params[:specialist].permit(:name, :profession)
    end
end
