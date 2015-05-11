class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def twitter
    omniauth_authentication 'Twitter'
  end

  def vkontakte
    # render :text => request.env["omniauth.auth"].to_yaml
    omniauth_authentication 'Vkontakte'
  end

  def facebook
    omniauth_authentication 'Facebook'
  end

  def omniauth_authentication(provider_kind)
    data = session['devise.omniauth_data'] = User.build_omniauth_auth_cookie_hash(request.env['omniauth.auth'])

    @user = User.from_omniauth(data)

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, :kind => provider_kind) if is_navigational_format?
    elsif @user.email.blank?
      flash[:error] = I18n.t('devise.registrations.add_email')
      render 'users/omniauth_callbacks/add_email'
    else
      flash[:error] = I18n.t('errors.messages.social_email_taken')
      session['devise.omniauth_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end