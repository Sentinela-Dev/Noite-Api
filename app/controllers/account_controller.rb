# frozen_string_literal: true

require_relative 'application_controller'
require './app/adapters/usecases/auth/index'
require './app/adapters/usecases/user/index'

## AccountController
class AccountController < ApplicationController
  get '/' do
    authenticate!
    return p 'sarve'
  end

  post '/get-token' do
    request_body = request.body.read
    data = JSON.parse(request_body)

    begin
      user = User::Login.new(email: data['email'], password: data['password']).call
      return p 'invalid email or password i dont know' unless user

      token = Auth::GenToken.new.with_user(user).call
      return { token: }.to_json
    rescue StandardError => e
      status 400
      return p e.message
    end
  end

  post '/new-account' do
    request_body = request.body.read
    data = JSON.parse(request_body, symbolize_names: true)

    begin
      user = User::Register.new(params: data).call
      return user.public_infos.to_json
    rescue StandardError => e
      return p e.message
    end
  end
end
