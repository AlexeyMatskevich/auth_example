# frozen_string_literal: true

Sequel.migration do
  change do
    extension :date_arithmetic

    create_table(:account_login_change_keys) do
      foreign_key :id, :accounts, primary_key: true, type: :uuid
      String :key, null: false
      String :login, null: false
      DateTime :deadline, null: false, default: Sequel.date_add(Sequel::CURRENT_TIMESTAMP, days: 1)
    end
  end
end
