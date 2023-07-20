# frozen_string_literal: true

require './app/adapters/usecases/user/select'

module Auth
  ## GetUser
  class GetUser
    def initialize(token:)
      @token = token
    end

    def call
      jwt_user = Auth::ReadToken.new(token: @token).call[0]
      User::Select.new.fromId(jwt_user[:id])
    rescue StandardError
      puts $!
      nil
    end
  end
end
