class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
   layout 'admins/header'
  def index
    @orders = Order.all.page(params[:page]).per(10)
    @customer = current_customer
    #@carts = @customer.carts.all
    #@order = Order.find(params[:id])
  end

  def show
    @order = Order.all
    @order_details = @order.order_details.all
		@sum = 0
  end

  def update
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :shipping_cost, :pay_money, :pay_way, :name, :postcode, :address, :status)
  end
end
