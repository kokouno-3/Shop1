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

      if params[:order][:order] == "0"
        @order.postcode = @customer.postcode
        @order.address = @customer.address
        @order.name = @customer.last_name + @customer.first_name
      elsif params[:order][:order] == "1"
        @address = Address.find(params[:order][:id])
        @order.postcode = @address.postcode
        @order.address = @address.address
        @order.name = @address.name
      end
  end

  def complete
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to publics_orders_complete_path
  end

  def index
    orders = current_customer.orders.all.reverse_order # reverse_orderで逆順で表示する。reverse_orderを使うためにあえてordersに代入している
    @orders = orders.page(params[:page]).per(10)
    @total = 0
  end

  def show
    # @customer = current_customer
    # @order = @customer.order
    @order = Order.find(params[:id])
    @total = 0
  end

  private

  def order_params
    params.require(:order).permit(:postcode, :address, :name, :customer_id, :shipping_cost, :pay_money, :pay_way, :statu, :shipping_info)
  end

end
