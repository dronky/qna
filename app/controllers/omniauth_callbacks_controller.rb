class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    provider_logon('Facebook')
  end

  def twitter
    provider_logon('Twitter')
  end

  def register
    User.register_for_oauth(params[:email], params[:provider], params[:uid])
    redirect_to new_user_session_path, notice: 'You have to confirm your email address before continuing.'
  end

  private

  def provider_logon(provider)
    @user = User.find_for_oauth(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: provider) if is_navigational_format?
    else
      # session["devise.#{provider.downcase}_data"] = request.env["omniauth.auth"].except("extra")
      # redirect_to new_user_registration_url
      @oauth_data = request.env["omniauth.auth"].except("extra")
      render 'oauth/email_for_user'
    end
  end
end