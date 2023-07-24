# frozen_string_literal: true

require './config/mongo_database'
require './app/models/user_model'
require './lib/changeset/index'

## UserRepository
class UserRepository
  attr_reader :collection

  def initialize
    client = MongoDatabase.database_connection
    @collection = client[:users]
  end

  def find_by_id(id)
    result = @collection.find({ "_id": BSON::ObjectId(id) }).limit(1).first

    return nil unless result

    UserModel.new(result)
  end

  def find_by_email(email)
    result = @collection.find(email:).sort(created_at: -1).limit(1).first
    return nil unless result

    UserModel.new(result)
  end

  def insert(user)
    u = Changeset::Validate.new(UserModel, user)
                           .cast(:email, :name, :password)
                           .presence(%i[email name password])
                           .call

    result = @collection.insert_one(u.to_hash)
    return nil unless result

    find_by_id(result.inserted_id)
  end

  def email_exists?(email)
    email = find_by_email(email)

    return false unless email

    true
  end
end
