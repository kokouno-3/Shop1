class Publics::CartsController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def index
    @customer = current_customer
    @carts = @customer.carts.all
    @cart = current_customer.carts.find_by(item_id: params[:item_id])
    @total = 0
  end

  def create
    @customer = current_customer
    @item = Item.find(params[:cart][:item_id]) # findでparamsの、cartモデルのitem_idを探す
    # @cart.amount == present?
    # redirect_to item_path(@item)
    # end
    if Cart.exists?(item_id: @item, customer_id: @customer) # exists?でitem_idとcustomer_idが存在するかを確認する
      @cart = Cart.find_by(item_id: @item.id, customer_id: @customer) # find_byでカートに存在するitem_idとcustomer_idを探す
      @cart.amount += params[:cart][:amount].to_i # カートに存在する商品の数量@cart.amountにparamsでcartモデルのamountを足し、代入する。
      @cart.update(amount: @cart.amount) # 上の行で定義した@cart.amountをupdateする
      redirect_to carts_path
    else
      @cart = Cart.new(cart_params)
      @cart.customer_id = current_customer.id
      if @cart.save
        redirect_to carts_path
      else
        flash[:cart] = "カートに入れる個数を入力してください"
        redirect_back(fallback_location: root_path)
      end
    end
  end

  def update
    @cart = Cart.find(params[:id])
    @cart.update(cart_params)
    if @cart.amount == 0
      @cart.destroy
    end
    redirect_to carts_path
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to carts_path
  end

  def destroy_all
    current_customer.carts.destroy_all
    redirect_to carts_path
  end

  private
  def cart_params
    params.require(:cart).permit(:item_id, :customer_id, :amount)
  end

end
