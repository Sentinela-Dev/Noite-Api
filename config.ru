# frozen_string_literal: true

require 'dotenv'
Dotenv.load
require 'sinatra'
require 'sinatra/base'
require './config/mongo_database'

Dir.glob('./app/mvc/{helpers,controllers}/*.rb').each { |file| require file }

# Routes
map('/account') { run AccountController }
