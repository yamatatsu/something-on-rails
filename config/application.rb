require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Myapp
  class Application < Rails::Application
    config.load_defaults 5.1

    config.i18n.available_locales = %i[ja en]
    config.i18n.default_locale = :ja
    config.i18n.fallbacks = %i[ja en]

    config.generators do |g|
      g.assets false
      g.helper false
      g.template_engine = :slim
    end
  end
end
