class Publics::HomesController < ApplicationController
  layout 'publics/header'
  def top
    @items = Item.all.page(params[:page]).per(4)
    # @genre = Genre.all.find(params[:id])
    @genres = Genre.where(status: 'true').all
  end

  def about
  end
end
