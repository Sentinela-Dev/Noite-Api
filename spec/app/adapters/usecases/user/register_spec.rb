# frozen_string_literal: true

require './app/adapters/usecases/user/index'
require './app/models/user_model'
require './app/repositories/user_repository'

RSpec.describe User::Register do
  before(:all) do
    @user = User::Register.new(params: {
                                 'name': 'John',
                                 'email': 'john@email.com',
                                 'password': 'something'
                               }).call
  end

  after(:all) do
    UserRepository.new.collection.drop
  end

  context 'Valid user infos' do
    it 'all correct' do
      expect(@user.class).to be(UserModel)
      expect(@user.email).to eq('john@email.com')
      expect(@user.password).not_to eq('something')
    end
  end

  context 'Invalid infos' do
    it 'same email' do
      user = User::Register.new(params: { 'name': 'morte', 'email': 'john@email.com', 'password': '123' })

      expect { user.call }.to raise_error(StandardError, 'Email alwary exists')
    end

    it 'without required infos' do
      user = User::Register.new(params: { 'name': 'morte', 'password': '123' })

      expect { user.call }.to raise_error(StandardError, 'Nil fields ["email"]')
    end
  end
end
