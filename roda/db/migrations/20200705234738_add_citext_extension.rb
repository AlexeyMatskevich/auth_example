# frozen_string_literal: true

Sequel.migration { change { run "CREATE EXTENSION IF NOT EXISTS citext" } }
