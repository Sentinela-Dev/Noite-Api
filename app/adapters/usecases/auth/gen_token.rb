require 'jwt'

module Auth
  class GenToken
    def initialize
      @payload = {}
    end

    def with_user(user)
      @payload = user.jwt_infos
      self
    end

    def call
      @payload[:timestamp] = Time.now.utc.to_i
      JWT.encode(@payload, SECRET_KEY, Auth::ALGORITHM)
    end
  end
end
