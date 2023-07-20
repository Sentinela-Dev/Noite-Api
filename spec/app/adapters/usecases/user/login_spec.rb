# frozen_string_literal: true

require './app/adapters/usecases/user/index'
require './app/models/user_model'
require './app/repositories/user_repository'

RSpec.describe User::Login do
  let(:valid_user) do
    {
      'name': 'John',
      'email': 'john@email.com',
      'password': 'something'
    }
  end

  after(:all) do
    UserRepository.new.collection.drop
  end

  context 'Login' do
    it 'all correct' do
      registered_user = User::Register.new(params: valid_user).call
      user = User::Login.new(email: valid_user[:email], password: valid_user[:password]).call

      expect(registered_user.email).to eq(user.email)
      expect(registered_user.id).to eq(user.id)
    end

    it 'incorrect login' do
      User::Register.new(params: valid_user).call
      user = User::Login.new(email: valid_user[:email], password: 'salveamigao').call

      expect(user).to eq(nil)
    end
  end
end
