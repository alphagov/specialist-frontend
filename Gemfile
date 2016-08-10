source 'https://rubygems.org'

gem 'rails', '~> 5.0'

gem 'airbrake', '~> 4.0'
gem 'govuk_frontend_toolkit', '3.0.1'
gem 'logstasher', '0.4.8'
gem 'plek', '~> 1.11'
gem 'sass-rails', '~> 5.0'
gem 'slimmer', '~> 9.0'
gem 'uglifier', '>= 1.3.0'
gem 'unicorn', '4.8.1'

if ENV['API_DEV']
  gem 'gds-api-adapters', path: '../gds-api-adapters'
else
  gem 'gds-api-adapters', '20.1.1'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :test do
  gem 'cucumber-rails', require: false
  gem 'govuk-content-schema-test-helpers', '1.3.0'
  gem 'launchy'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 3.0'
  gem 'webmock'
end

group :development, :test do
  gem 'pry'
end
