source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1.4'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'slim-rails'
gem 'rails-controller-testing'
gem 'jquery-rails'
gem 'devise'
gem 'responders', '~> 2.0'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'bootstrap-sass'
gem 'cancancan'
gem 'doorkeeper'
gem "active_model_serializers", "~> 0.9.7"
gem 'oj'
gem 'oj_mimic_json'
gem 'sidekiq'
gem 'whenever'
gem 'sinatra', '>= 1.3.0', require: nil
gem 'mysql2'
gem 'thinking-sphinx'
gem 'dotenv'
gem 'dotenv-deployment', require: 'dotenv/deployment'
gem 'therubyracer'
gem 'remotipart'
gem 'cocoon'
gem 'carrierwave'
gem 'redis', "~> 3.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'capybara-webkit', '~> 1.14.0'
  gem 'capybara-email'
end

group :development do
  gem 'capistrano', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano-rvm', require: false
  gem 'capistrano-sidekiq', require: false
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'letter_opener'
end

group :test do
  gem 'shoulda-matchers'
  gem 'json_spec'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
