# frozen_string_literal: true

require './app/models/flow_model'
require './app/repositories/der_flow_repository'

module Flow
  ## Create
  class Update
    def initialize(flow_id:, user:, flow_repository: DerFlowRepository)
      @flow_id = flow_id
      @user = user
      @flow_repository = flow_repository.new
    end

    def with_tables(tables)
      @tables = tables
      self
    end

    def with_edges(edges)
      @edges = edges
      self
    end

    def call
      flow = @flow_repository.find_flow(@flow_id, @user)

      raise StandardError, 'Flow not found' unless flow

      @flow_repository.update_tables(flow.id, @tables) if @tables
      @flow_repository.update_edges(flow.id, @edges) if @edges
      @flow_repository.find_by_id(flow.id)
    end
  end
end
