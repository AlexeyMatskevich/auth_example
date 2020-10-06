# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:account_verification_keys) do
      foreign_key :id, :accounts, primary_key: true, type: :uuid
      String :key, null: false
      DateTime :requested_at, null: false, default: Sequel::CURRENT_TIMESTAMP
      DateTime :email_last_sent, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
