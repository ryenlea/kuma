Padrino.configure_apps do
  # enable :sessions
  set :session_secret, APP_CONFIG['session_secret']
  set :protection, true
  set :protect_from_csrf, false
end

Padrino.mount('Kuma::App', :app_file => Padrino.root('app/app.rb')).to('/')
