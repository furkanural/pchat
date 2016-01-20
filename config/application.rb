require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module PChat
  class Application < Rails::Application
    config.action_dispatch.default_headers = {
        'Access-Control-Allow-Origin' => 'http://my-web-service-consumer-site.com',
        'Access-Control-Request-Method' => %w{GET POST OPTIONS}.join(",")
    }
    # Use the responders controller from the responders gem
    config.app_generators.scaffold_controller :responders_controller

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
