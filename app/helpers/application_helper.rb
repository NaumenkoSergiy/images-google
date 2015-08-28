module ApplicationHelper
  def authorization_code_url
    "https://accounts.google.com/o/oauth2/auth?scope=http://picasaweb.google.com/data/&redirect_uri=#{ENV['AUTH_REDIRECT_URL']}/&response_type=code&client_id=#{ENV['GOOGLE_CLIENT_ID']}"
  end
end
