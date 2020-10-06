# frozen_string_literal: true

require "rodauth/migrations"

Sequel.migration do
  change do
    create_table(:account_previous_password_hashes) do
      primary_key :id, type: :Bignum
      foreign_key :account_id, :accounts, type: :uuid
      String :password_hash, null: false
    end
    Rodauth.create_database_previous_password_check_functions(self)
  end
end
