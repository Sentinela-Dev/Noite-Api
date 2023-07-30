# frozen_string_literal: true

require './app/usecases/der_flow/index'
require './app/usecases/user/index'

RSpec.describe Flow::Create do
  before(:all) do
    @user = User::Register.new(params: {
                                 'name': 'John',
                                 'email': 'john@email.com',
                                 'password': 'something'
                               }).call

    @other_user = User::Register.new(params: {
                                       'name': 'Invalid John',
                                       'email': 'invalid_john@email.com',
                                       'password': 'something'
                                     }).call
  end

  let(:valid_flow_params) do
    {
      name: 'something',
      description: 'tal',
      owner: @user.email
    }
  end

  after(:all) do
    UserRepository.new.collection.drop
    DerFlowRepository.new.collection.drop
  end

  context 'Valid infos' do
    it 'all correct' do
      flow = Flow::Create.new(params: valid_flow_params).call

      expect(flow.tables).to eq([])

      tables = { 'color': 'purple' }
      updated_flow = Flow::Update.new(flow_id: flow.id, user: @user).with_tables(tables).call

      expect(updated_flow.tables['color']).to eq(tables[:color])
    end

    it 'invalid user' do
      flow = Flow::Create.new(params: valid_flow_params).call

      tables = { 'color': 'purple' }
      updated_flow = Flow::Update.new(flow_id: flow.id, user: @other_user).with_tables(tables)

      expect { updated_flow.call }.to raise_error(StandardError, 'Flow not found')
    end
  end
end
