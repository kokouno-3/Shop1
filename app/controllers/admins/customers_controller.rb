class Admins::CustomersController < ApplicationController
  layout 'admins/header'
  
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
     @customer = Customer.find(params[:id])
     if @customer.update(customer_params)
      redirect_to admins_customer_path(@customer)
     else
      render :edit
     end
  end
  
  private
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phonenumber, :email, :is_deleted)
  end
end
