# frozen_string_literal: true

require './utils/changeset'

RSpec.describe Changeset::Validate do
  context 'Cast values' do
    it 'cast user' do
      user = {
        name: 'John Doe',
        age: 18
      }

      token = Changeset::Validate.new(user).cast([:name]).call

      expect(token.class).to be(Hash)

      expect(token[:name]).to be('John Doe')

      expect(token[:age]).to be(nil)
    end
  end

  context 'Required valuess' do
    it 'Required a not used field' do
      user = {
        name: 'John Doe',
        age: 18
      }

      task = Changeset::Validate.new(user)

      expect { task.required([:popo]).call }.to raise_error(ChangesetValidationException)
    end

    it 'Require a used field' do
      user = {
        name: 'John Doe',
        age: 18
      }

      task = Changeset::Validate.new(user)

      user = task.required([:name]).call

      expect(user.class).to be(Hash)
    end
  end
end
