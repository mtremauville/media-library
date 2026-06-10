require_relative "boot"

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module MediaLibrary
  class Application < Rails::Application
    config.middleware.use Rack::Attack

    # CORS pour API
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins ENV.fetch("ALLOWED_ORIGINS", "localhost:3000")
        resource "*", headers: :any, methods: [:get, :post, :put, :delete, :options]
      end
    end

    # Force SSL en production
    config.force_ssl = true if Rails.env.production?

    # Headers de sécurité
    config.action_dispatch.default_headers = {
      "X-Frame-Options"        => "SAMEORIGIN",
      "X-XSS-Protection"       => "1; mode=block",
      "X-Content-Type-Options" => "nosniff",
      "Referrer-Policy"        => "strict-origin-when-cross-origin"
    }
  end
end
