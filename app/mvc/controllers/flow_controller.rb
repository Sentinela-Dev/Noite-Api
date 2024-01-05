# frozen_string_literal: true

require_relative 'application_controller'
require './app/usecases/der_flow/index'
require './utils/changeset'

## FlowController
class FlowController < ApplicationController
  before do
    content_type :json
  end

  get '/list' do
    authenticate!

    flows = Flow::Select.new.list_all(@current_user)
    { data: flows.map(&:basic_info) }.to_json
  end

  post '/create' do
    authenticate!

    request_body = request.body.read
    data = JSON.parse(request_body, symbolize_names: true)

    data[:owner] = @current_user.email

    begin
      flow = Flow::Create.new(params: data).call

      flow.to_hash.to_json
    rescue ChangesetValidationException => e
      puts e
      puts e.errors
    end
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

      updated_flow.info.to_json
    rescue StandardError => e
      p e
    end
  end
end
