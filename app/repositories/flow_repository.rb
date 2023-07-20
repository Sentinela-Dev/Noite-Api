# frozen_string_literal: true

## UserRepository
class FlowRepository
  def initialize
    client = MongoDatabase.database_connection
    @collection = client[:streamers]
  end

  def find; end

  def insert(flow)
    @collection.insert_one(flow)
  end

  def insert_many(*flow)
    @collection.insert_many(flow)
  end
end
