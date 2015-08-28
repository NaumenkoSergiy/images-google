require "signet/oauth_2/client"

class PicasaImages
  def initialize user_id, code
    @user_id = user_id
    @code    = code
  end

  def access_token
    signet = Signet::OAuth2::Client.new(
      code: @code,
      token_credential_uri: 'https://www.googleapis.com/oauth2/v3/token',
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      redirect_uri: 'http://localhost:3000/authorization_code'
    )

    signet.fetch_access_token!
  end
end
