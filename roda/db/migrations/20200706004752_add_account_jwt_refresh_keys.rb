# frozen_string_literal: true

Sequel.migration do
  change do
    extension :date_arithmetic

    create_table(:account_jwt_refresh_keys) do
      primary_key :id, type: :Bignum
      foreign_key :account_id, :accounts, null: false, type: :uuid
      String :key, null: false
      DateTime :deadline, null: false, default: Sequel.date_add(Sequel::CURRENT_TIMESTAMP, days: 1)
      index :account_id, name: :account_jwt_rk_account_id_idx
    end
  end
end
