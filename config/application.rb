require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Dream
  class Application < Rails::Application
  	config.exceptions_app = ->(env) { ExceptionsController.action(:show).call(env) }
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.autoload_paths += %W(#{config.root}/lib)
    #config.exception_handler = { dev: true }
    config.exception_handler = {
      dev: true, # allows you to turn ExceptionHandler "on" in development
      layouts: {
      	401 => 'error',
      	404 => 'error',
      	500 => 'error'
      }
      #Maybe add 403 later for moderating, add 405 as a precaution (say we're not sure why you performed this action, but try again),
      # => 500, say we experienced an error but not sure what, 422 say we were unable to process the instructions, 502 temporaty error
      # => all others could be hardcoded with a generic error page that says we don't know what happened but something is wrong
    }

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
