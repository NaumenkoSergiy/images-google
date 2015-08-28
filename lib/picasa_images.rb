require "signet/oauth_2/client"

class PicasaImages
  def initialize user_id
    @user_id = user_id
  end

  def access_token
    signet = Signet::OAuth2::Client.new(
      code: ENV['GOOGLE_CLIENT_CODE'],
      token_credential_uri: "https://www.googleapis.com/oauth2/v3/token",
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      redirect_uri: "urn:ietf:wg:oauth:2.0:oob"
    )

    signet.fetch_access_token!
  end
end
