# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.0'

gem 'hanami', '~> 2.0'
gem 'hanami-controller', '~> 2.0'
gem 'hanami-router', '~> 2.0'
gem 'hanami-validations', '~> 2.0'

gem 'dry-types', '~> 1.0', '>= 1.6.1'
gem 'puma'
gem 'rake'

# database
gem 'pg'
gem 'rom', '~> 5.3'
gem 'rom-sql', '~> 3.6'

# thread pool
gem 'parallel'

# background jobs
gem 'sidekiq'
gem 'sidekiq-scheduler'

group :development, :test do
  gem 'dotenv'
  gem 'rubocop', '~> 1.35', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rake', require: false
  gem 'rubocop-rspec', '~> 2.12', require: false
  gem 'rubocop-sequel', require: false
end

group :cli, :development do
  gem 'hanami-reloader'
end

group :cli, :development, :test do
  gem 'hanami-rspec'
end

group :development do
  gem 'guard-puma', '~> 0.8'
end

group :test do
  gem 'database_cleaner-sequel'
  gem 'rack-test'
  gem 'rom-factory'
end
