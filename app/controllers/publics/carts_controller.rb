class Publics::CartsController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'
  
  def index
    @customer = current_customer
    @carts = @customer.carts.all
    @cart = current_customer.carts.find_by(item_id: params[:item_id])
    #@item = @cart.item
  end

  def create
    @customer = current_customer
    if current_customer.carts.find_by(item_id: params[:item_id]).present?
      @cart = current_customer.carts.find_by(item_id: params[:item_id])
      @cart.amount += params[:cart][:amount]
      @cart.save
      redirect_to publics_carts_path
    else
      @cart = Cart.new(cart_params)
      @cart.customer_id = current_customer.id
      # @cart = current_customer.carts.find_by(item_id: params[:item_id]) ←これは要らない
      @cart.save
      redirect_to publics_carts_path
    end 
  end
  
  def update
    # @cart = current_customer.carts.find_by(item_id: params[:item_id])
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    if @cart.item == nil
      @cart.destroy
    end 
    redirect_to publics_carts_path
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to publics_carts_path
  end

  def destroy_all
    # @cart = Cart.find(params[:id])
    current_customer.carts.destroy_all
    redirect_to publics_carts_path
  end

  
  
  private
  def cart_params
    params.require(:cart).permit(:item_id, :customer_id, :amount)
  end

end
