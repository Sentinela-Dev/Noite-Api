# frozen_string_literal: true

require './app/models/flow_model'
require './app/repositories/der_flow_repository'

module Flow
  ## Create
  class Create
    def initialize(params:, flow: FlowModel, flow_repository: DerFlowRepository)
      @params = params
      @flow = flow
      @flow_repository = flow_repository.new
    end

    def call
      @params = Changeset::Validate.new(@params)
                                   .cast(%i[name description owner tables edges can_access])
                                   .required(%i[name description owner tables edges can_access])
                                   .call

      flow = @flow.new(@params)

      flow.created_at = Time.now.utc
      flow.updated_at = Time.now.utc

      @flow_repository.insert(flow.to_db)
    end
  end
end
