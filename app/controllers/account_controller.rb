# frozen_string_literal: true

require_relative 'application_controller'

## AccountController
class AccountController < ApplicationController
  get '/' do
    authenticate!
    'sarve'
  end
end
