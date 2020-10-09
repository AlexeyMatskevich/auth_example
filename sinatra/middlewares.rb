# frozen_string_literal: true

require 'sinatra/json'
require 'jwt'

class JWTAuthorizations
  def initialize(app)
    @app = app
  end

  def call(env)
    bearer = nil
    authorization = env.fetch('HTTP_AUTHORIZATION', '').split(' ')

    bearer = authorization[1] if authorization[0]&.match?(/Bearer/)

    if bearer
      payload = JWT.decode bearer, '1', true
      claims = payload.first

      env[:user] = User[claims['id']]
    end
    # access your claims here...

    @app.call env
  rescue JWT::ExpiredSignature
    [403, { 'Content-Type' => 'text/plain' }, ['The token has expired.']]
  rescue JWT::DecodeError
    [401, { 'Content-Type' => 'text/plain' }, ['A token must be passed.']]
  rescue JWT::InvalidIssuerError
    [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid issuer.']]
  rescue JWT::InvalidIatError
    [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid "issued at" time.']]
  end
end
