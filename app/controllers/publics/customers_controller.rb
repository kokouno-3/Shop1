class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      redirect_to customer_path(current_customer.id)
    else
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    #is_deletedカラムにフラグを立てる（defaultfalse(有効)をtrue(退会済み)にする）
    @customer.update(is_deleted: '退会済み')
    reset_session #ログアウトさせる
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit([:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :phonenumber, :email])
  end
end
