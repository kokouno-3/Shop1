class AdminsOrderDetailsController < ApplicationController
    before_action :authenticate_admin!
   layout 'admins/header'
  def update
  end
end
