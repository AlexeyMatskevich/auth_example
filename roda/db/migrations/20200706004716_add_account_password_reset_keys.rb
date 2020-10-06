# frozen_string_literal: true

Sequel.migration do
  change do
    extension :date_arithmetic

    create_table(:account_password_reset_keys) do
      foreign_key :id, :accounts, primary_key: true, type: :uuid
      String :key, null: false
      DateTime :deadline, null: false, default: Sequel.date_add(Sequel::CURRENT_TIMESTAMP, days: 1)
      DateTime :email_last_sent, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
