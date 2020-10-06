# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:account_authentication_audit_logs) do
      primary_key :id, type: :Bignum
      foreign_key :account_id, :accounts, null: false, type: :uuid
      DateTime :at, null: false, default: Sequel::CURRENT_TIMESTAMP
      String :message, null: false
      column :metadata, :jsonb
      index [:account_id, :at], name: :audit_account_at_idx
      index :at, name: :audit_at_idx
    end
  end
end
