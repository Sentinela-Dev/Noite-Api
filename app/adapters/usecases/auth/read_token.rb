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
      JWT.decode(@token, Auth::SECRET_KEY, true, { algorithm: Auth::ALGORITHM })
    end
  end
end
