class Publics::OrdersController < ApplicationController
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
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:postcode, :address, :name,)
  end

end
