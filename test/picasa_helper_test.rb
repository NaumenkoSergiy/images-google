require 'signet/oauth_2/client'

module PicasaHelperTest 
  def self.picasa_access_token code
    signet = Signet::OAuth2::Client.new(
      code: code,
      token_credential_uri: 'https://www.googleapis.com/oauth2/v3/token',
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      redirect_uri: "#{ENV['AUTH_REDIRECT_URL']}"
    )

    begin
      signet.fetch_access_token!
    rescue => e
      p 'Fetching access token:'
      p e.message
    end
  end
end
