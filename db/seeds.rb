# frozen_string_literal: true

ips = app['persistence.rom'].relations[:ips]

ips.insert(address: '8.8.8.8', enabled: true)
ips.insert(address: '167.172.108.25')
