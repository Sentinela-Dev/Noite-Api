# frozen_string_literal: true

require './app/models/user_model'
require './app/repositories/user_repository'
require './app/adapters/usecases/encrypt/index'

module User
  class Login
    def initialize(email:, password:, user_repository: UserRepository)
      @email = email
      @password = password
      @user_repository = user_repository.new
    end

    def call
      user = @user_repository.find_by_email(@email)
      password = Encrypt::Decode.new(hash: user.password).call

      return user if user && password == @password
    end
  end
end
