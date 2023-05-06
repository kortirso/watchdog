# Watchdog

Hanami application for monitoring IP addresses.

## Ruby version

- 3.2.0

## Installation

```bash
$ bundle install
$ createdb watchdog_development
$ createdb watchdog_test
$ bundle exec rake db:migrate
$ HANAMI_ENV=test bundle exec rake db:migrate
```

Rename `.env.example` and `.env.test.example`, and put your database credentials inside.

## Running application locally

```bash
hanami server
sidekiq -r ./config/sidekiq.rb
```

## Tests and checks

```bash
rspec
rubocop
```
