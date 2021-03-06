require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
Bundler.require(*Rails.groups)

module Api
  class Application < Rails::Application
    config.load_defaults 5.2
    config.api_only = true

    config.hosts << ENV['DEFAULT_API_URI']
    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('app', 'domains', 'repositories')
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use ActionDispatch::Session::CookieStore
  end
end
