class Users::AccountsController < ApplicationController

  def create
    data = session["devise.omniauth_data"]
    data['email'] = params[:user][:email]
    @user = User.from_omniauth(data)

    if @user.save
      flash[:notice] = I18n.t("devise.registrations.signed_up")
      sign_in_and_redirect(:user, @user)
    else
      flash[:error] = I18n.t("devise.omniauth_callbacks.failure", :kind => data['provider'].titleize, :reason => @user.errors.full_messages.first)
      render "users/omniauth_callbacks/add_email"
    end
  end

end