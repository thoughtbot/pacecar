# Create a rails app
module Pacecar
  class Application < Rails::Application
    config.secret_key_base = 'test'
    config.paths['config/database'] = ['spec/support/database.yml']
    config.eager_load = false
  end
end
Pacecar::Application.initialize!

# Run migrations
require_relative 'support/create_schema'
CreateSchema.suppress_messages { CreateSchema.up }
