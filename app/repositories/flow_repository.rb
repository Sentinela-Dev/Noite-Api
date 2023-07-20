# frozen_string_literal: true

require './app/models/flow_model'

## UserRepository
class FlowRepository
  attr_reader :collection

  def initialize
    client = MongoDatabase.database_connection
    @collection = client[:flows]
  end

  def insert(flow)
    result = @collection.insert_one(flow)
    find_by_id(result.inserted_id)
  end

  def find_by_id(id)
    result = @collection.find({ "_id": BSON::ObjectId(id) }).limit(1).first

    return nil unless result

    FlowModel.new(result)
  end

  def find_flow(flow_id, user)
    result = @collection.find({
                                "$or": [
                                  { owner: user.email },
                                  { can_access: user.email }
                                ],
                                "_id": BSON::ObjectId(flow_id)
                              }).limit(1).first

    return nil unless result

    FlowModel.new(result)
  end
end
