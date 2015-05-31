ENV['RACK_ENV'] = 'test'

require './app/server'
require 'database_cleaner'
require 'capybara/rspec'
require_relative 'features/helpers/session.rb'
Capybara.app = Sinatra::Application
DataMapper.auto_migrate!
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
