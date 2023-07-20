# frozen_string_literal: true

require './app/models/flow_model'
require './app/repositories/flow_repository'

module Flow
  ## Create
  class Select
    def initialize(flow_repository: FlowRepository)
      @flow_repository = flow_repository.new
    end

    def get_flow(id:, user:)
      @flow_repository.find_flow(id, user)
    end

    def list_flows(user:)
      @flow_repository.find_flow(id, user)
    end

    def list_all(user)
      @flow_repository.find_all_by_user(user)
    end
  end
end
