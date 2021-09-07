# frozen_string_literal: true

source 'https://rubygems.org'
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby `cat .ruby-version`

gem 'bootsnap', '>= 1.4.4', require: false
gem 'kaminari' # pagination
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 6.1.4', '>= 6.1.4.1'

group :development, :test do
  gem 'dotenv-rails'
  gem 'factory_bot'
  gem 'pry-byebug'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.3'
end

group :test do
  gem 'shoulda-matchers', '~> 4.5.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
