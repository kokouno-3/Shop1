class Publics::ItemsController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header' 
  def index
  end

  def show
  end
end
