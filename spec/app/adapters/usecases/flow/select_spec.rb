# frozen_string_literal: true

require './app/adapters/usecases/flow/index'
require './app/adapters/usecases/user/index'

RSpec.describe Flow::Select do
  before(:all) do
    @owner = User::Register.new(params: {
                                  'name': 'John',
                                  'email': 'john@email.com',
                                  'password': 'something'
                                }).call

    @guest = User::Register.new(params: {
                                  'name': 'John',
                                  'email': 'mario@email.com',
                                  'password': 'something'
                                }).call

    @nobody = User::Register.new(params: {
                                   'name': 'John',
                                   'email': 'haha@email.test',
                                   'password': 'something'
                                 }).call

    @flow = Flow::Create.new(params: {
                               name: 'something',
                               description: 'tal',
                               owner: @owner.email,
                               can_access: [@guest.email]
                             }).call

    @flow2 = Flow::Create.new(params: {
                                name: 'cuca',
                                description: 'tal',
                                owner: @owner.email,
                                can_access: [@guest.email]
                              }).call
  end

  let(:valid_flow_params) do
    {
      name: 'something',
      description: 'tal',
      owner: @user.email,
      can_access: [@guest.email]
    }
  end

  after(:all) do
    UserRepository.new.collection.drop
    FlowRepository.new.collection.drop
  end

  context 'Single Flow' do
    it 'all correct' do
      guest_flow = Flow::Select.new.get_flow(id: @flow.id, user: @guest)
      nobody_flow = Flow::Select.new.get_flow(id: @flow.id, user: @nobody)

      expect(guest_flow.class).to eq(FlowModel)
      expect(nobody_flow).to eq(nil)
    end
  end

  context 'Multiple Flows' do
    it 'all correct' do
      guest_flow = Flow::Select.new.list_all(@guest)
      nobody_flow = Flow::Select.new.list_all(@nobody)

      expect(guest_flow.class).to eq(Array)
      expect(guest_flow[0].class).to eq(FlowModel)
      expect(guest_flow[0].owner).to eq(@owner.email)
      expect(guest_flow[0].name).to eq(@flow.name)
      expect(guest_flow[1].name).to eq(@flow2.name)

      expect(nobody_flow).to eq([])
    end
  end
end
