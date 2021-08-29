source 'https://rubygems.org'
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby `cat .ruby-version`

gem 'rails', '~> 6.1.4', '>= 6.1.4.1'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'rack-cors'
gem 'kaminari' # pagination

group :development, :test do
  gem 'dotenv-rails'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'factory_bot'
end

group :development do
  gem 'listen', '~> 3.3'
end

group :test do
  gem 'shoulda-matchers', '~> 4.5.1'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
