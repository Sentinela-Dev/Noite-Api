# frozen_string_literal: true

require 'bcrypt'

module Encrypt
  ## Decode
  class Decode
    def initialize(hash:)
      @hash = hash
    end

    def call
      BCrypt::Password.new(@hash)
    end
  end

  ## Encode
  class Encode
    def initialize(password:)
      @password = password
    end

    def call
      BCrypt::Password.create(@password)
    end
  end
end
