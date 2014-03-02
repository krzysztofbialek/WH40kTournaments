source 'http://rubygems.org'

gem "rails", "3.2.13"

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

gem 'mysql2'
gem 'haml'
gem 'haml-rails'
gem 'twitter-bootstrap-rails', "~> 2.0rc0"
gem "bcrypt-ruby", :require => "bcrypt"
gem 'RedCloth'
gem 'mercury-rails'
gem "friendly_id", "~> 4.0.9"
gem "aasm"
gem "acts_as_paranoid"
gem 'tinymce-rails'
gem 'active_model_serializers'
gem 'gon', '~> 3.0.5'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem "therubyracer"
  gem 'backbone-on-rails'
  gem "less-rails"
  gem 'sass-rails',   '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'uglifier', '>= 1.0.3'
  gem "ejs", "~> 1.1.1"
  gem 'jquery-ui-rails'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the web server

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development do
  gem "byebug"
  gem 'webrick', '1.3.1' 
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "letter_opener"
  gem "quiet_assets"
end

group :test do
  gem "byebug"
  gem 'mocha'
  gem 'shoulda'
  gem 'factory_girl_rails'
  gem 'capybara'
end

group :production do
  gem 'pg'
  gem 'unicorn'
  gem 'newrelic_rpm'
end
