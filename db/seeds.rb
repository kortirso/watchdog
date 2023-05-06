# frozen_string_literal: true

ips = app['persistence.rom'].relations[:ips]

ips.insert(address: '8.8.8.8', enabled: true) # google dns server
ips.insert(address: '167.172.108.25', enabled: true) # pullkeeper.dev
ips.insert(address: '104.244.42.193', enabled: true) # twitter
ips.insert(address: '77.88.55.60', enabled: true) # yandex
ips.insert(address: '87.240.132.67', enabled: true) # vk.com
ips.insert(address: '151.101.193.140', enabled: true) # reddit
ips.insert(address: '104.21.72.173', enabled: true) # rutracker.org
ips.insert(address: '140.82.113.3', enabled: true) # github
ips.insert(address: '172.65.251.78', enabled: true) # gitlab
ips.insert(address: '157.240.3.35', enabled: true) # facebook