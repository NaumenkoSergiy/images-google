class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if @user.persisted?
      session[:token] = request.env['omniauth.auth']['credentials']['token']
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
      sign_in_and_redirect @user, event: :authentication
    else
      session['devise.google_data'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def authorization_code
    session[:code] = params['code']
    session[:token] = PicasaImages.new(current_user.email, params['code']).access_token
    @client = Picasa::Client.new(user_id: current_user.email, access_token: session[:token]['access_token'])
    redirect_to root_path
  end
end
