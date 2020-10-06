# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:account_login_failures) do
      foreign_key :id, :accounts, primary_key: true, type: :uuid
      Integer :number, null: false, default: 1
    end
  end
end
