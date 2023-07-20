# frozen_string_literal: true

require 'bcrypt'

module Encrypt
  class Encode
    def initialize(password:)
      @password = password
    end

    def call
      BCrypt::Password.create(@password)
    end
  end
end
