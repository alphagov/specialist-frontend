source 'https://rubygems.org'

gem 'rails', '4.1.11'
if ENV['API_DEV']
  gem 'gds-api-adapters', :path => '../gds-api-adapters'
else
  gem 'gds-api-adapters', '20.1.1'
end

gem 'exception_notification', '4.0.1'
gem 'aws-ses', '0.5.0', require: 'aws/ses'
gem 'plek', '1.11.0'
gem 'unicorn', '4.8.1'
gem 'slimmer', '9.0.0'

gem 'logstasher', '0.4.8'

gem 'airbrake', '4.0.0'

group :development do
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'cucumber-rails', '1.4.0', require: false
  gem 'webmock', '1.17.1'
  gem 'rspec-rails', '2.14.1'
  gem 'launchy'
  gem 'govuk-content-schema-test-helpers', '1.3.0'
end

group :assets do
  gem 'sass-rails', '~> 4.0.2'
  gem 'uglifier', '>= 1.3.0'
  gem 'govuk_frontend_toolkit', '3.0.1'
end

group :development, :test do
  gem 'debugger'
  gem 'pry'
end
