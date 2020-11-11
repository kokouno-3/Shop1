class Admins::ItemsController < ApplicationController
  before_action :authenticate_admin!
   layout 'admins/header'
  def index
    @items = Item.all.page(params[:page]).per(10)
    @genres= Genre.all
  end

  def new
    @item = Item.new
    @genres= Genre.all
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admins_item_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres= Genre.all
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admins_item_path(@item)
    else
      render :edit
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :explanation, :price, :image, :is_status, :genre_id)
  end
end

