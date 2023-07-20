# frozen_string_literal: true

require './app/adapters/usecases/user/index'
require './app/models/user_model'

RSpec.describe User::Register do
  let(:valid_user) do
    {
      'name': 'John',
      'email': 'john@email.com',
      'password': 'something',
      'roels': [:user]
    }
  end

  context 'Valid user infos' do
    it 'all correct' do
      user = User::Register.new(params: valid_user).call
      puts user.to_db
      expect(user.class).to be(UserModel)
    end
  end
end
