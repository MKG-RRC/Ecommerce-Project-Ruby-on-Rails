source "https://rubygems.org"

ruby "3.1.4"

gem "rails", "~> 7.1.6"
gem "sprockets-rails"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "sassc-rails"
gem "image_processing", "~> 1.2"

gem "kaminari"

# Authentication + Admin Dashboard (must be in this order)
gem "devise"
gem "activeadmin"

# Windows zoneinfo
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Bootsnap
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "web-console"
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
