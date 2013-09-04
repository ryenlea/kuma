require File.expand_path('../../config/sprockets', __FILE__)

module Kuma
  class App < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    helpers Sprockets::Helpers

    enable :sessions

    configure do
        set :sprockets, SPROCKETS

        Sprockets::Helpers.configure do |config|
            manifest_path      = Padrino.root('public/assets/manifest.json')
            config.environment = sprockets
            config.prefix      = '/assets'
            config.manifest    = Sprockets::Manifest.new(sprockets, manifest_path)
            config.digest      = true
            config.public_path = public_folder

            config.debug       = PADRINO_ENV == "production" ? false : true
        end

        
    end

    before /admin*/ do
        unless user_login?
            redirect "/login"
        end
    end

    configure :production do
      enable :caching

      #log system
      Raven.configure do |config|
         config.dsn = APP_CONFIG['sentry_dsn']
      end

      use Raven::Rack
    end

    error ActiveRecord::RecordNotFound do
        halt 404
    end

    error 401 do
        render 'error/401'
    end
      
    error 403 do
        render 'error/403'
    end
      
    error 404 do
        render 'error/404', :layout => 'application'
    end

    error 500 do
        render 'error/500'
    end
  end
end
