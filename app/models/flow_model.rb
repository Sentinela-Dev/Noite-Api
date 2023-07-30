# frozen_string_literal: true

## FlowModel
class FlowModel
  attr_accessor :id, :name, :description, :tables, :edges, :owner, :can_access, :created_at, :updated_at

  def initialize(user_info = {})
    @id = user_info[:_id]

    @name = user_info[:name]
    @description = user_info[:description]
    @owner = user_info[:owner]

    @tables = user_info[:tables] || []
    @edges = user_info[:edges] || []
    @can_access = user_info[:can_access] || []

    @created_at = user_info[:created_at]
    @updated_at = user_info[:updated_at]
  end

  def to_hash
    {
      id:,
      name:,
      description:,
      tables:,
      edges:,
      owner:,
      can_access:,
      created_at:,
      updated_at:
    }
  end

  def info
    {
      name:,
      description:,
      owner:,
      tables:,
      edges:,
      can_access:,
      created_at:,
      updated_at:
    }
  end

  def basic_info
    {
      name:,
      description:,
      owner:,
      can_access:,
      created_at:,
      updated_at:
    }
  end

  def to_db
    {
      name:,
      description:,
      owner:,
      tables:,
      edges:,
      can_access:,
      created_at:,
      updated_at:
    }
  end
end
