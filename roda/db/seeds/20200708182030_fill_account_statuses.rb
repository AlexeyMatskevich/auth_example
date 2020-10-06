# frozen_string_literal: true

Sequel.seed do
  def run
    DB.from(:account_statuses).import([:id, :name], [[1, "Unverified"], [2, "Verified"], [3, "Closed"]])
  end
end
