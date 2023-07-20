# frozen_string_literal: true

require './app/models/flow_model'
require './app/repositories/flow_repository'

module Flow
  ## Create
  class Create
    def initialize(params:, flow: FlowModel, flow_repository: FlowRepository)
      @params = params
      @flow = flow
      @flow_repository = flow_repository.new
    end

    def call
      flow = @flow.new(@params)

      flow.created_at = Time.now.utc
      flow.updated_at = Time.now.utc

      @flow_repository.insert(flow.to_db)
    end
  end
end
