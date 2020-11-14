class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller? #(customer側の新規登録情報を保存)

  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      admins_sign_in_path # ログアウト後に遷移するpathを設定(admin側)
    else
      root_path # ログアウト後に遷移するpathを設定(customer側)
    end
  end

  def after_sign_in_path_for(resource)
    case resource
      when Admin
        admins_path # ログイン後に遷移するpathを設定(admin側)
      when Customer
        root_path  # ログイン後に遷移するpathを設定(customer側)
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :phonenumber])
  end
end
