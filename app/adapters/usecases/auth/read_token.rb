# frozen_string_literal: true

require 'jwt'
require './app/adapters/usecases/user/index'

module Auth
  ## ReadToken
  class ReadToken
    def initialize(token:)
      @token = token
    end

    def call
      jwt = JWT.decode(@token, Auth::SECRET_KEY, true, { algorithm: Auth::ALGORITHM })[0]
      yet_valid = Time.at(jwt['timestamp']) + MAX_LIVE > Time.now

      raise 'expired token' unless yet_valid

      jwt
    end
  end
end
