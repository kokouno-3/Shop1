class Publics::OrdersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'
  def new
    @order = Order.new
    @customer = current_customer
    @addresses = @customer.addresses
  end

  def confirm
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

    if params[:order][:order] == "2"
			@order.postcode = params[:order][:postcode]
			@order.address = params[:order][:address]
			@order.name = params[:order][:name]
		  Address.create!(customer_id: @customer.id, postcode: @order.postcode, address: @order.address, name: @order.name)
    end

  end

  def complete
    @customer = current_customer
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to orders_complete_path
    @customer = current_customer
    @carts = @customer.carts.all
    @carts.each do |cart|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart.item_id
      @order_detail.price = cart.item.price
      @order_detail.amount = cart.amount
      @order_detail.order_id = @order.id
      @order_detail.save
    end
    current_customer.carts.destroy_all
    # Address.create!(customer_id: @customer.id, postcode: @order.postcode, address: @order.address, name: @order.name)
  end

  def index
    @customer = current_customer
    orders = current_customer.orders.all.reverse_order # reverse_orderで逆順で表示する。reverse_orderを使うためにあえてordersに代入している。
    @orders = orders.page(params[:page]).per(6)
    @total = 0
    @customer = current_customer
  end

  def show
    @customer = current_customer
    @order = Order.find(params[:id])
    @total = 0
  end

  private

  def order_params
    params.require(:order).permit(:postcode, :address, :name, :customer_id, :shipping_cost, :pay_money, :pay_way, :status, :shipping_info)
  end

end
