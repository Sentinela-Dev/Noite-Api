# frozen_string_literal: true

require './app/adapters/usecases/flow/index'
require './app/adapters/usecases/user/index'

RSpec.describe Flow::Create do
  before(:all) do
    @user = User::Register.new(params: {
                                 'name': 'John',
                                 'email': 'john@email.com',
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
    FlowRepository.new.collection.drop
  end

  context 'Valid infos' do
    it 'all correct' do
      flow = Flow::Create.new(params: valid_flow_params).call

      expect(flow.class).to be(FlowModel)
      expect(flow.owner).to eq(@user.email)
      expect(flow.name).to eq(valid_flow_params[:name])
      expect(flow.description).to eq(valid_flow_params[:description])
      expect(flow.tables).to eq([])
      expect(flow.edges).to eq([])
    end
  end
end
