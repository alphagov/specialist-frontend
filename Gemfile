source 'https://rubygems.org'

gem 'rails', '4.0.2'
if ENV['API_DEV']
  gem 'gds-api-adapters', :path => '../gds-api-adapters'
else
  gem 'gds-api-adapters', '8.2.3'
end

gem 'exception_notification', '4.0.1'
gem 'plek', '1.3.0'

group :test do
  gem 'cucumber-rails', '1.4.0', require: false
  gem 'webmock', '1.17.1'
end

group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
end

gem 'debugger', group: [:development, :test]
