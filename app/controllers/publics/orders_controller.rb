class Publics::OrdersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'
  def new
    @order = Order.new
    @addresses = Address.all
    @customer = current_customer
    @customers = Customer.all
  end

  def comfirm
    @order = Order.new(order_params)
    @customer = current_customer
      if :order == 1
        @order.postcode = @customer[:postcode]
        @order.address = @customer[:address]
        @order.name = @customer[:name]
      elsif :order == 2
        @order.postcode = @address[:postcode]
        @order.address = @address[:address]
        @order.name = @address[:name]
      elsif :order == 3
        @order.postcode = params[:postcode]
        @order.address = params[:address]
        @order.name = params[:name]
      end
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to publics_orders_complete_path
  end

  def index
    @customer = current_customer
    @orders = @customer.orders.all
  end

  def show
    @customer = current_customer
    @orders = @customer.orders.all
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:postcode, :address, :name, :customer_id, :shipping_cost, :pay_money, :pay_way, :status)
  end

end
