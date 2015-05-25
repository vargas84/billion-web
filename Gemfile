source 'https://rubygems.org'

# Project-specific gems
gem 'high_voltage', '~> 2.3.0'
gem 'paranoia', '~> 2.1.2'
gem 'bootstrap-sass', '~> 3.3.4'
gem 'font-awesome-sass', '~> 4.3.2.1'
gem 'mailchimp-api', require: 'mailchimp'
gem 'figaro', '~> 1.1.1'
gem 'email_validator', '~> 1.6.0'
gem 'lodash-rails', '~> 3.7.0'

gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0', group: :doc

group :development, :test do
  gem 'letter_opener', '~> 1.3.0'
end

group :stage, :development, :test do
  gem 'factory_girl_rails', '~> 4.5.0'
end

group :development, :test do
  # Project-specific gems
  gem 'rubocop', require: false
  gem 'rspec-rails', '~> 3.0'
  gem 'shoulda-matchers', '~> 2.8.0'
  gem 'rspec-its', '~> 1.2.0'
  gem 'json-schema', '~> 2.5.1'
  gem 'database_cleaner', '~> 1.4.1'

  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
end
