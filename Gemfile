source 'https://rubygems.org'

gem 'rails', '4.2.0'

# gem 'bootstrap-sass',          '3.2.0.0'
gem 'foundation-rails', '5.4.5'
gem 'sass-rails', '~> 4.0.3'
gem 'haml-rails'
gem 'uglifier', ' >= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'simple_form'
gem 'annotate', '~> 2.6.5'
gem 'devise'
gem 'omniauth'
gem 'omniauth-facebook'
gem 'figaro'
gem 'faker'
gem 'will_paginate'
gem 'foundation-will_paginate'
# gem 'bcrypt', '~> 3.1.7'

gem 'pg'
group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'byebug',      '3.4.0'
  gem 'web-console', '2.0.0.beta3'
  gem 'spring',      '1.1.3'
  gem 'letter_opener'
end

group :test do
  gem 'capybara'
  gem 'guard-rspec'
  gem 'launchy'
end

group :production do
  # gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
  gem 'unicorn',        '4.8.3'
end

ruby '2.2.0'

##### Setup Quickref
#
### Devise
# https://github.com/plataformatec/devise
# rails g devise:install
# rails g devise MODEL_NAME
#
### Foundation
# rails g foundation:install
#
### Simple Form
# https://github.com/plataformatec/simple_form
# rails g simple_form:install
# options: --bootstrap, --foundation
#
### Annotate
# Usage: from root dir: annotate
# options: --exclude fixtures, tests, factories, serializers, routes, delete
#
### RSpec
# rails g rspec:install
# in spec/spec_helper: require "capybara/rspec"
# in .rspec: --format documentaion
# in confi/application.r
# config.generators do |g|
#       g.test_framework :rspec,
#         :fixtures => true,
#         :view_specs => false,
#         :helper_specs => false,
#         :routing_specs => false,
#         :controller_specs => true,
#         :request_specs => true
#       g.fixture_replacement :factory_girl, :dir => "spec/factories"
#     end