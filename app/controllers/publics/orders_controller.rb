class Publics::OrdersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'
  def new
    @order = Order.new
    @addresses = Address.all
    @customer = current_customer
  end

  def comfirm
    @order = Order.new(order_params)
    @customer = current_customer
    @carts = @customer.carts.all
    @cart = current_customer.carts.find_by(item_id: params[:item_id])
    @total = 0

      if params[:order][:order] == 0
        @order.postcode = @customer.postcode
        @order.address = @customer.address
        @order.name = @customer.last_name
      else params[:order][:order] == 1
        @address = Address.find(params[:order][:id])
        @order.postcode = @address.postcode
        @order.address = @address.address
        @order.name = @address.name
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
    params.require(:order).permit(:postcode, :address, :name, :customer_id, :shipping_cost, :pay_money, :pay_way, :statu, :shipping_info)
  end

end
