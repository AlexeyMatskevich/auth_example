require 'sinatra/json'
require 'jwt'

class JWTAuthorizations
  def initialize app
    @app = app
  end

  def call(env)
    begin
      bearer = env.fetch('HTTP_AUTHORIZATION').slice(7..-1)
      key = OpenSSL::PKey::RSA.new "1"
      payload = JWT.decode bearer, key, true
      claims = payload.first

      if claims['iss'] == 'user'
        env[:user] = User.find(claims['id'])
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
end