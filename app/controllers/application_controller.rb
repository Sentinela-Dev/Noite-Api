# frozen_string_literal: true

require 'sinatra/base'

## UserMiddleware
class ApplicationController < Sinatra::Base
  include AuthHelper

  configure :production, :development do
    enable :logging
  end

  before do
    @current_user ||= current_user(request)
  end
end
