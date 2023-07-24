require_relative 'gen_token'
require_relative 'read_token'
require_relative 'get_user'

module Auth
  ALGORITHM = ENV['JWT_ALGORITHM']
  SECRET_KEY = ENV['JWT_SECRET_KEY']
  MAX_LIVE = 60 * 60 * 24 # 24 hours
end
