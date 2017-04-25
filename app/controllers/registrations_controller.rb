class RegistrationsController < Devise::RegistrationsController

    def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name ,:email ,:gender ,:mobile_phone ,:birth_date ,:password ,:password_confirmation])
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name ,:email ,:gender ,:mobile_phone ,:birth_date ,:password ,:password_confirmation]) 
  end

      def update_resource(current_user, user_params)
      	
    current_user.update_without_password(user_params)
  end

    def update_resource(current_user, params)
    current_user.update_with_password(params)
  end
  def user_params
    params(:user).permit(:name ,:email ,:gender ,:mobile_phone ,:birth_date )
  end
end
