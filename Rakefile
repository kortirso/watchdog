# frozen_string_literal: true

require 'hanami/rake_tasks'
require 'rom/sql/rake_task'

desc 'basis for tasks'
task :environment do
  require_relative 'config/app'
  require 'hanami/prepare'
end

namespace :db do
  desc 'prepare task'
  task setup: :environment do
    Hanami.app.prepare(:persistence)
    ROM::SQL::RakeSupport.env = Hanami.app['persistence.config']
  end
end
