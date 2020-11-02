class Publics::ItemsController < ApplicationController
  layout 'publics/header'
  def index
    @items = Item.all.page(params[:page]).per(8)
  end

  def show
    @items = Item.all.page(params[:page]).per(8)
    @item = Item.find(params[:id])
  end
  
  private
  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :is_status)
  end
  
end
