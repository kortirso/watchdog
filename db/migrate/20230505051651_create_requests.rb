# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :requests do
      primary_key :id

      foreign_key :ip_id, :ips

      column :completed, :boolean, null: false, default: true
      column :response_time, :numeric, precision: 5, scale: 2, null: false, default: 0
    end
  end
end
