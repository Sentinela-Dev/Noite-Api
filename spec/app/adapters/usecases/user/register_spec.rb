# frozen_string_literal: true

require './app/adapters/usecases/user/index'
require './app/models/user_model'
require './app/repositories/user_repository'

RSpec.describe User::Register do
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

  context 'Valid user infos' do
    it 'all correct' do
      user = User::Register.new(params: valid_user).call

      expect(user.class).to be(UserModel)
      expect(user.email).to eq(valid_user[:email])
      expect(user.password).not_to eq(valid_user[:password])
    end
  end
end
