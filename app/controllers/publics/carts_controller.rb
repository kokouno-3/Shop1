class Publics::CartsController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def index
    @customer = current_customer
    @carts = @customer.carts.all
    @cart = current_customer.carts.find_by(item_id: params[:item_id])
    @total = 0
    #@item = @cart.item
  end

  def create
    @customer = current_customer
    @item = Item.find_by(params[:cart][:item_id]) # findでparamsの、cartモデルのitem_idを探す
    if Cart.exists?(item_id: @item, customer_id: @customer) # exists?でitem_idとcustomer_idを存在するか確認する
      @cart = Cart.find_by(item_id: @item.id, customer_id: @customer) # find_byでカートに存在するitem_idとcustomer_idを探す
      @cart.amount += params[:cart][:amount].to_i # カートに存在する商品の数量@cart.amountにparamsでcartモデルのamountを足し、代入する。
      @cart.update(amount: @cart.amount) # 上の行で定義した@cart.amountをupdateする
    # if current_customer.carts.find_by(item_id: params[:item_id]).present?
    # @cart = current_customer.carts.find_by(item_id: params[:item_id])
    # @cart.amount += params[:cart][:amount].to_i
    # @cart.update(amount: @cart.amount)
      redirect_to publics_carts_path
    else
      @cart = Cart.new(cart_params)
      @cart.customer_id = current_customer.id
      @cart.save
      redirect_to publics_carts_path
    end
  end

  def update
    # @cart = current_customer.carts.find_by(item_id: params[:item_id])
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    if @cart.item == 0
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
