# frozen_string_literal: true

require "bundler/setup"
require "roda"
require "sequel/core"
require 'middlewares.rb'

class App < Roda
  class User < Sequel::Model
  end

  use JWTAuthorization
  # Database block
  url = ENV.fetch("DATABASE_URL") { "postgres://postgres:postgres@localhost:5432" }
  url += "/sinatra_#{ENV["RACK_ENV"]}" if url.gsub("postgres://", "").split("/")[1].nil?

  DB = Sequel.connect(url)
  DB.freeze

  post('/login') do
    user = User.where(email: params['email'], password: params['password']).first!

    JWT.encode({id: user.id}, "1")
  end

  post('/registration') do
    User.create(email: params['email'], password: params['password'])
  end
end
