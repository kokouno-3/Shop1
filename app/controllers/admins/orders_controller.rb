class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admins/header'
  def index
    @customer = current_customer
    customer = params[:customer_id]
    if @orders = params[:customer_id]
      order = Order.where(customer_id: customer).all
      orders = order.all.reverse_order
    elsif @orders = params[:created_at]
      range = Date.today.beginning_of_day..Date.today.end_of_day
      order = Order.where(created_at: range)
      orders = order.all.reverse_order
    else
      @orders = Order.all
      orders = Order.all.reverse_order
    end 
      @orders = orders.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total = 0
  end

  def update
    @order = Order.find(params[:id]) #注文詳細の特定
    @order.update(order_params) #注文ステータスの更新
    if @order.status == "入金待ち"
      OrderDetail.where(order_id: @order.id).update_all(making_status: "製作不可") #注文ステータスが「入金待ち」なら、製作ステータスを「製作不可」に更新
    elsif @order.status == "入金確認"
      OrderDetail.where(order_id: @order.id).update_all(making_status: "製作待ち") #注文ステータスが「入金確認」なら、製作ステータスを「製作待ち」に更新
    end
    redirect_to admins_order_path(@order) #注文詳細へ
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :shipping_cost, :pay_money, :pay_way, :name, :postcode, :address, :status)
  end
end
