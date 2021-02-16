# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  #def new
  #  super
    
  #end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  def after_sign_up_path_for(user)
    email = user[:email]
    if Company.user_admin? (email) and Company.common_user?(email)
      super(user)
    elsif Company.user_admin? (email) and !Company.common_user?(email)
      new_company_path
    else
      super(user)
    end
    #email = User.find_by(params[:email]).email
    #company_name = email.gsub(/.+@([^.]+).+/, '\1')
    #company_search = Company.where('company_name like ?', "%#{company_name}%")
    #common_emails = ['gmail', 'outlook', 'hotmail']
    #flash[:notice] = 'Bem vindo! Você realizou seu registro com sucesso.'
    #if !company_search.any? && !common_emails.include?(company_name)
    #  redirect_to new_company_path
    #else
    #  super(resource)
    #end
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
