# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
require 'spec_helper'
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.include JsonSpec::Helpers
  config.include Helpers
  config.include Capybara::DSL
end