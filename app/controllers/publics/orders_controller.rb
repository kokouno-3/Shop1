class Publics::OrdersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'
  def new
    @order = Order.new
    @customer = current_customer
    @customers = Customer.all
  end

  def comfirm
    @order = Order.new(order_params)
    @customer = current_customer
      if :order == 1
        @cusromer = current_customer
      elsif :order == 3
        @orders = Order.find(params[:id])
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
