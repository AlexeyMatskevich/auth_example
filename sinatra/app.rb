# frozen_string_literal: true
require 'sequel/core'
require 'sequel/model'
# Database block
url = ENV.fetch('DATABASE_URL') { 'postgres://postgres:postgres@localhost:5432' }
url += "/sinatra_#{ENV['RACK_ENV']}" if url.gsub('postgres://', '').split('/')[1].nil?

DB = Sequel.connect(url)
DB.freeze

require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/json'
require 'json'
require_relative 'models/user'
require_relative 'middlewares.rb'

class App < Sinatra::Base
  use JWTAuthorizations

  before do
    body = request.body.read.to_s

    return if body.empty?

    @req_data = JSON.parse(request.body.read.to_s)
  end

  post('/login') do
    user = User.where(email: @req_data['login'], password: @req_data['password']).first!

    token = JWT.encode({ id: user.id }, '1')

    status 200
    headers \
      "Content-Type"   => "application/json",
      "Authorization" => "Bearer #{token}"
  end

  post('/registration') do
    user = User.create(email: @req_data['email'], password: @req_data['password'])

    content_type :json

    if user
      { success: "Are you registered" }.to_json
    else
      { error: "Are you not registered" }.to_json
    end
  end

  post('/me') do
    content_type :json

    if user
      { id: user.id, email: user.email }.to_json
    else
      { error: "You are not authenticated" }.to_json
    end
  end

  def user
    env[:user]
  end
end
