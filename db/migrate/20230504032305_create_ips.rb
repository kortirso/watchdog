# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :ips do
      primary_key :id
      column :enabled, :boolean, null: false, default: false
    end
  end
end
