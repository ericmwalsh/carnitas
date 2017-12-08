require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Portfolio
  class Application < Rails::Application
    ::Dotenv::Railtie.load if Rails.env.development? || Rails.env.test?

    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # config.cache_store = :redis_store, ENV['REDIS_URL'], { expires_in: 90.minutes }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
