class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to publics_customer_path(current_customer.id)
  end

  def unsubscribe
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end


private
  def customer_params
    params.require(:customer).permit([:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, ])
  end
end
