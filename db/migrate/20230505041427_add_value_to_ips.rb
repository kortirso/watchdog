# frozen_string_literal: true

ROM::SQL.migration do
  change do
    alter_table(:ips) do
      add_column :address, String, null: false, default: ''
    end
  end
end
