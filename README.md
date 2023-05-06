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

### Database seeds

Check db/seeds.rb and run manually code inside.

## Running application locally

Web application for checking statistics.
```bash
hanami server
```

Sidekiq background jobs for performing monitoring.
```bash
sidekiq -r ./config/sidekiq.rb
```

## Tests and checks

```bash
rspec
rubocop
```
