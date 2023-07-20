# frozen_string_literal: true

## UserModel
class UserModel
  attr_accessor :id, :name, :email, :password, :email_confirmed, :created_at, :updated_at, :roles

  def initialize(user_info = {})
    @id = user_info[:_id]
    @name = user_info[:name]
    @email = user_info[:email]
    @password = user_info[:password]
    @email_confirmed = user_info[:email_confirmed] || false
    @created_at = user_info[:created_at]
    @updated_at = user_info[:updated_at]
    @roles = user_info[:roles]
  end

  def to_hash
    {
      id:,
      name:,
      email:,
      password:,
      email_confirmed:,
      created_at:,
      updated_at:,
      roles:
    }
  end

  def to_db
    {
      name:,
      email:,
      password:,
      email_confirmed:,
      created_at:,
      updated_at:,
      roles:
    }
  end
end
