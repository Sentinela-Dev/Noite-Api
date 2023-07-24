# frozen_string_literal: true

require 'bcrypt'

module Encrypt
  class Decode
    def initialize(hash:)
      @hash = hash
    end

    def call
      BCrypt::Password.new(@hash)
    end
  end
end
