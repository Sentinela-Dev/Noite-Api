# frozen_string_literal: true

require './app/usecases/user/index'
require './app/repositories/user_repository'
require './app/usecases/auth/index'

RSpec.describe Auth::GenToken do
  let(:user) do
    User::Register.new(params: {
                         'name': 'John',
                         'email': 'john@email.com',
                         'password': 'something'
                       }).call
  end

  after(:all) do
    UserRepository.new.collection.drop
  end

  context 'Gen user token' do
    it 'valid token' do
      token = Auth::GenToken.new.with_user(user).call
      expect(token.class).to be(String)
    end
  end
end
