class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_out_path_for(resource)
    new_admin_session_path # (admin側)
  end
   
    def after_sign_in_path_for(resource)
    case resource
    when Admin
        admins_path
    when Customer
        about_path
    end
    end
   
   protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :phonenumber])
  end

end
