# frozen_string_literal: true

require 'jwt'
require './app/adapters/usecases/user/index'

ALGORITHM = ENV['JWT_ALGORITHM']
SECRET_KEY = ENV['JWT_SECRET_KEY']

module Auth
  ## ReadToken
  class ReadToken
    def initialize(token:)
      @token = token
    end

    def call
      JWT.decode(@token, SECRET_KEY, true, { algorithm: ALGORITHM })
    end
  end
end
