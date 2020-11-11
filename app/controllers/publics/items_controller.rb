class Publics::ItemsController < ApplicationController
  layout 'publics/header'
  
  def index
    @items = Item.all.page(params[:page]).per(8)
    @customer = current_customer
  end

  def show
    @item = Item.find(params[:id])
    @genre = Genre.all
    @cart = Cart.new
    if @cart.amount == "個数選択"
      redirect_to item_path(item)
    end
    @customer = current_customer
  end

  def genre_items
    @genre = Genre.find(params[:id])
    @items = @genre.items.all
    @items = @items.page(params[:page])
    @customer = current_customer
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :is_status)
  end

end
