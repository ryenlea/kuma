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

    use OmniAuth::Builder do
        provider :identity, fields: [:nickname, :email], model: User, on_failed_registration: -> {|env| }
    end
  end
end
