# frozen_string_literal: true

require './app/models/user_model'
require './app/repositories/user_repository'
require './app/providers/encrypt_provider'
require './utils/changeset'

module User
  class Register
    def initialize(params:, user: UserModel, user_repository: UserRepository)
      @params = params
      @user = user
      @user_repository = user_repository.new
    end

    def call
      user = @user.new(@params)

      can_register? user

      user.password = Encrypt::Encode.new(password: user.password).call
      user.created_at = Time.now.utc
      user.updated_at = Time.now.utc
      user.roles = [:user]

      @user_repository.insert(user.to_db)
      @user_repository.find_by_email(user.email)
    end

    private

    def can_register?(user)
      Changeset::Validate.new(user.to_hash)
                         .cast(%i[email name password])
                         .required(%i[email name password])

      raise StandardError, 'Email alwary exists' if @user_repository.email_exists?(user.email)
    end
  end
end
