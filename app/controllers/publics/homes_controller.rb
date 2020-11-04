class Publics::HomesController < ApplicationController
  layout 'publics/header'
  def top
    @items = Item.all.page(params[:page]).per(4)
    @genres = Genre.where(status: "true").all
  end

  def about
  end
end
