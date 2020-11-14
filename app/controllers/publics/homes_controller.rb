class Publics::HomesController < ApplicationController
  layout 'publics/header'
  
  def top
    @items = Item.all.page(params[:page]).per(4)
    @genres = Genre.where(status: 'true').all
    @customer = current_customer
  end

  def about
  end
  
end
