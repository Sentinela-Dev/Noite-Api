# frozen_string_literal: true

require './app/usecases/user/index'
require './app/models/user_model'
require './app/repositories/user_repository'

RSpec.describe User::Login do
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

  context 'Login' do
    it 'all correct' do
      user = User::Login.new(email: 'john@email.com', password: 'something').call

      expect(@user.email).to eq(user.email)
      expect(@user.id).to eq(user.id)
    end

    it 'incorrect login' do
      user = User::Login.new(email: 'john@email.com', password: 'salveamigao').call

      expect(user).to eq(nil)
    end
  end

  context 'invalid login' do
    it 'email empty' do
      user = User::Login.new(email: '', password: 'something')
      expect { user.call }.to raise_error(StandardError, 'No user founded with email ')
    end

    it 'not existent email' do
      user = User::Login.new(email: 'imdoesnotexist', password: 'something')
      expect { user.call }.to raise_error(StandardError, 'No user founded with email imdoesnotexist')
    end
  end
end
