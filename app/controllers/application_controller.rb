class ApplicationController < ActionController::Base

  def after_sign_out_path_for(resource)
    new_admin_session_path # ログアウト後に遷移するpathを設定(admin側)
  end

   def after_sign_in_path_for(resource)
    admins_path # ログアウト後に遷移するpathを設定(admin側)
   end

end
