ENV['RAILS_ENV'] = 'test'

require 'rails/all'
require 'rspec/rails'

require 'fake_app'
require 'pacecar'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

require 'factory_girl'
require 'factories'

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.include FactoryGirl::Syntax::Methods
end
