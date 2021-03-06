# frozen_string_literal: true

require "bundler/setup"
require "roda"
require "sequel/core"

class App < Roda
  # Database block
  url = ENV.fetch("DATABASE_URL") { "postgres://postgres:postgres@localhost:5432" }
  url += "/roda_#{ENV["RACK_ENV"]}" if url.gsub("postgres://", "").split("/")[1].nil?

  DB = Sequel.connect(url)
  DB.freeze

  plugin :rodauth, json: :only do
    db DB
    enable :login, :create_account, :logout, :jwt

    account_password_hash_column :password_hash
    jwt_secret "1"
  end

  route do |r|
    r.rodauth
  end

  freeze
end
