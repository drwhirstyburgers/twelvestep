class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def terms
    if current_user.terms.any?
      return
    else
      redirect_to new_user_term_path(current_user)
    end
  end

  def choose_role
    if current_user.role == nil
      redirect_to edit_user_registration_path
      flash[:alert] = "Whoops! Please choose what you're here for!"
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me,
      :years_sober, :catchphrase, :bio, :role]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
