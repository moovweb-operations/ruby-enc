source 'https://rubygems.org'

gem 'syslogger', git: 'https://github.com/jbussdieker/syslogger.git', :branch => 'implement_log_formatter'
gem 'rails', '4.2.8'
gem 'rake', '< 11.0'
gem 'mysql2', '0.3.18'
gem 'puppet', '3.8.5' # NOTE: this should match what we are using in production
gem 'syck'
gem 'mcollective-client'
gem 'chartkick'
gem 'groupdate'
gem 'rails-bootstrap', '~> 3.0.0'
gem 'kaminari'
gem 'unicorn'

gem 'sass-rails',   '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.0.3'
gem 'jquery-rails'
gem 'awesome_print'

# attr_accessible` is extracted out of Rails into a gem.
# Please use new recommended protection model for params(strong_parameters)
# or add `protected_attributes` to your Gemfile to use old one
gem 'protected_attributes'

gem 'responders', '~> 2.0'

gem 'newrelic_rpm'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', :platforms => :ruby

group :development, :test do
  gem 'rspec', '~> 3.6.0'
  gem 'rspec-rails', '~> 3.6.0'
  gem 'factory_bot_rails'
  gem 'coveralls', require: false
end

gem 'web-console', '~> 2.0', group: :development

group :test do
  gem 'faker'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
end

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
