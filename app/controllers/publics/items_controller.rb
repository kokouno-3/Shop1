class Publics::ItemsController < ApplicationController
  # before_action :authenticate_customer!
  layout 'publics/header'
  def index
    @items = Item.all.page(params[:page]).per(8)
    @customer = current_customer
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart = Cart.new
    @customer = current_customer
  end

  def genre_items
    @genre = Genre.find(params[:id])
    @items = @genre.items.all
    @customer = current_customer
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :is_status)
  end

end
