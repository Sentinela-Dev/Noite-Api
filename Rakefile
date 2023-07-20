# frozen_string_literal: true

# Rakefile
require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

namespace :db do
end

task :start_server do
  system('bundle exec puma')
end

task up: %i[start_server]
