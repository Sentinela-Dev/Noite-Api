# frozen_string_literal: true

require './config/mongo_database'
require './app/models/user_model'

## UserRepository
class UserRepository
  def initialize
    client = MongoDatabase.database_connection
    @collection = client[:users]
  end

  def find_by_email(email)
    result = @collection.find(email:).sort(created_at: -1).limit(1).first
    UserModel.new(result)
  end

  def insert(user)
    @collection.insert_one(user)
  end
end
