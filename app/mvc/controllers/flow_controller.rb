# frozen_string_literal: true

require_relative 'application_controller'
require './app/usecases/der_flow/index'

## AccountController
class FlowController < ApplicationController
  before do
    content_type :json
  end

  get '/list' do
    authenticate!

    flows = Flow::Select.new.list_all(@current_user)
    return { data: flows.map(&:basic_info) }.to_json
  end

  post '/create' do
    authenticate!

    request_body = request.body.read
    data = JSON.parse(request_body, symbolize_names: true)
    params = {
      name: data[:name],
      description: data[:description],
      owner: @current_user.email
    }

    flow = Flow::Create.new(params:).call

    flow.to_hash.to_json
  end

  post '/update/:id' do |id|
    authenticate!

    request_body = request.body.read
    data = JSON.parse(request_body, symbolize_names: true)

    begin
      updated_flow = Flow::Update.new(flow_id: id, user: @current_user)
                                 .with_tables(data[:tables])
                                 .with_edges(data[:edges])
                                 .call

      return updated_flow.info.to_json
    rescue StandardError => e
      return p e
    end
  end
end
