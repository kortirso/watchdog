# frozen_string_literal: true

ROM::SQL.migration do
  change do
    create_table :requests do
      primary_key :id

      foreign_key :ip_id, :ips

      column :response_time, :numeric, precision: 5, scale: 2
    end
  end
end
