class Publics::CartsController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'
  
  def index
    @carts = Cart.all
    @item = Item.find(parmas[:id])
  end

  def update
    @cart = current_customer.carts.find_by(item_id: params[:item_id])
    if @cart.update(cart_params)
      redirect_to carts_path
    else
      render :index
    end 
  end

  def destroy
    @cart = current_customer.carts.find_by(item_id: params[:item_id])
    @cart.destroy
    redirect_to carts_path
  end

  def destroy_all
    @cart = current_customer.carts.find_by(item_id: params[:item_id])
    @cart.destroy_all
    redirect_to carts_path
  end

  def create
    if current_customer.carts.find_by(item_id: params[:item_id]).present?
      @cart = current_customer.carts.find_by(item_id: params[:item_id])
      @cart.amount += params[:cart][:amount]
      @cart.save
      redirect_to carts_path
    else
      @cart_new = Cart.new(cart_params)
      @cart_new.save
      redirect_to carts_path
    end 
  end
  
  private
  def cart_params
    params.require(:cart).permit(:item_id, :customer_id, :amount)
  end

end
