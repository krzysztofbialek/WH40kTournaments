source 'http://rubygems.org'

gem "rails", "3.2.13"


gem 'mysql2'
gem 'haml'
gem 'haml-rails'
gem 'twitter-bootstrap-rails', "~> 2.0rc0"
gem "bcrypt-ruby", :require => "bcrypt"
gem 'RedCloth'
gem "friendly_id", "~> 4.0.9"
gem "aasm"
gem "acts_as_paranoid"
gem 'tinymce-rails'
gem 'active_model_serializers'
gem 'gon', '~> 3.0.5'
gem 'simple_form'
gem 'carrierwave'
gem 'chartkick'

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

group :test, :development do
  gem "byebug"
  gem "letter_opener"
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem "thin"
  gem "quiet_assets"
  gem 'rack-mini-profiler'
end

group :test do
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
