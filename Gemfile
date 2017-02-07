source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails"
gem "rails", "~> 5.0.0", ">= 5.0.0.1"
gem "pg"
gem "puma", "~> 3.0"

# Other gems
gem "rack-cors"
gem "decent_exposure"
gem "active_model_serializers", git: "https://github.com/rails-api/active_model_serializers.git"
gem "interactor"
gem "responders"
gem "jwt"
gem "bcrypt"
gem "faker"
gem "google-authenticator-rails"

group :test do
  gem "capybara"
  gem "email_spec"
  gem "shoulda-matchers"
  gem "json_spec"
end

group :development, :test do
  gem "byebug", platform: :mri
  gem "brakeman", require: false
  gem "bundler-audit", require: false
  gem "dotenv-rails"
  gem "rspec-rails"
  gem "rspec-its"
  gem "factory_girl_rails"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
  gem "rspec_api_documentation", branch: "rspec-3.5"
end

group :development do
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-commands-rspec"
  gem "spring-watcher-listen", "~> 2.0.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
