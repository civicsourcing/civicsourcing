source 'https://rubygems.org'

gem 'rails'
gem 'rails-api'

gem 'capistrano', '~> 3.1.0'
gem 'capistrano-rails-console', :git => 'git://github.com/valgusk/capistrano-rails-console.git'
gem 'capistrano-bundler', '~> 1.1.2'
gem 'capistrano-rails', '~> 1.1.1'

gem 'capistrano-rbenv', '~> 2.0'

gem "pg"

gem "thin"

gem 'premailer-rails'

gem "active_model_serializers", :git => 'git://github.com/timothycommoner/active_model_serializers.git', branch: "feature/support_polymorphic_associations"

gem "figaro"

gem 'adhocracy'
gem 'flexible_feeds'

gem 'friendly_id', '~> 5.0.0'
gem "strip_attributes"

gem 'cancan'
gem "devise"
gem 'merit', :git => 'git://github.com/timothycommoner/merit.git'

gem 'carrierwave'
gem 'mini_magick'

gem "quiet_assets"

gem "sprockets", "<= 2.11.0"
gem "coffee-rails"
gem "sass-rails"
gem "uglifier"

gem "jquery-rails"
gem "jquery-fileupload-rails"

gem 'qunit-rails'

gem "ember-rails"
gem "ember-source"
gem "emblem-rails"
gem "handlebars-source"

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
end

group :development, :test do
  gem 'debugger'
  gem 'factory_girl_rails'
  gem "guard-rspec"
  gem 'guard-livereload'
  gem 'guard-sass', :require => false
  gem 'guard-coffeescript'
  gem 'rspec-rails'
end

group :test do
  gem 'database_cleaner'
  gem 'launchy'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
end

group :production do
  gem "exception_notification", "~> 4.0.1"
end

