class OrdersController < ApplicationController
  
  # load_and_authorize_resource
  before_action :set_order, only: %i[ show edit update destroy ]

  def index
    @orders = Order.filter(params.slice(:client_name, :price_start, :price_end))
  end


  def show
  end


  def new
    @order = Order.new
  end


  def edit
  end


  def create
    @order = Order.new(permitted_order_params)

    if @order.save
      redirect_to order_url(@order), notice: "Order was successfully created."
    else
      render :new
    end
  end


  def update
    if @order.update(permitted_order_params)
      redirect_to order_url(@order), notice: "Order was successfully updated."
    else
      render :edit
    end
  end


  def destroy
    @order.destroy
    redirect_to orders_url, notice: "Order was successfully destroyed."
  end

  private

    def set_order
      @order = Order.find(params[:id])
    end


    def permitted_order_params
      params[:order].permit(:client_name, 
        :client_phone_number, 
        :description,
        services_attributes: [:id, :name, :order_id, :specialist_id, :category_id, :price, :_destroy])
    end
end
