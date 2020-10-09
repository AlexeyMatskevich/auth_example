# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:users) do
      uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
      citext :email, null: false
      String :password, null: false
      constraint :valid_email, email: /^[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+$/
      index :email, unique: true
    end
  end
end
