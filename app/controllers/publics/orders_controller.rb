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
    @carts = @customer.carts.all
    @carts.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart.item_id
      @order_detail.price = cart.item.price
      @order_detail.amount = cart.amount
      @order_detail.order_id = @order.id
      @order_detail.save
    end 
  end

  def index
    orders = current_customer.orders.all.reverse_order # reverse_orderで逆順で表示する。reverse_orderを使うためにあえてordersに代入している。
    @orders = orders.page(params[:page]).per(10)
    @total = 0
  end

  def show
    # @customer = current_customer
    # @order = @customer.order
    @customer = current_customer
    @order = Order.find(params[:id])
    @total = 0
  end

  private

  def order_params
    params.require(:order).permit(:postcode, :address, :name, :customer_id, :shipping_cost, :pay_money, :pay_way, :status, :shipping_info)
  end

end
