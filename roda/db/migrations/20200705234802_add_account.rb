# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:accounts) do
      uuid :id, primary_key: true, default: Sequel.function(:gen_random_uuid)
      foreign_key :status_id, :account_statuses, null: false, default: 1
      citext :email, null: false
      String :password_hash, null: false
      constraint :valid_email, email: /^[^,;@ \r\n]+@[^,@; \r\n]+\.[^,@; \r\n]+$/
      index :email, unique: true, where: { status_id: [1, 2] }
    end
  end
end
