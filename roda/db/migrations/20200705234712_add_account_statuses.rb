# frozen_string_literal: true

Sequel.migration do
  change do
    create_table(:account_statuses) do
      Integer :id, primary_key: true
      String :name, null: false, unique: true
    end
  end
end
