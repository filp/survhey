
source "https://rubygems.org"

gem "rails", "4.2.1"
gem "bcrypt", "3.1.10"

gem "pg"
gem "oj"
gem "bourbon"
gem "flutie"
gem "haml-rails"
gem "sass", "~> 3.4.14"
gem "sass-rails"
gem "puma", "~> 2.11.3"
gem "foreman", require: false
gem "jquery-rails"

group :development do
  gem "spring"
  gem "quiet_assets"
  gem "better_errors"
  gem "binding_of_caller"
end

group :development, :test do
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.1.0"
  gem "simplecov", require: false
  gem "dotenv-rails"
end

group :development, :doc do
  gem "yard"
  gem "kramdown"
end

group :test do
  gem "shoulda-matchers", "~> 2.8.0", require: false
  gem "timecop"
end

group :production, :staging do
  gem "rack-timeout"
  gem "rails_12factor"
end
