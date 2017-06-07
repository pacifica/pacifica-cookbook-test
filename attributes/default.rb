default['postgresql']['password']['postgres'] = 'postgres'
default['postgresql']['config']['listen_addresses'] = '*'
default['postgresql']['pg_hba'] = [
  { type: 'local', db: 'all', user: 'postgres', addr: nil, method: 'ident' },
  { type: 'local', db: 'all', user: 'all', addr: nil, method: 'ident' },
  { type: 'host', db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'md5' },
  { type: 'host', db: 'all', user: 'all', addr: '::1/128', method: 'md5' },
  { type: 'host', db: 'metadata', user: 'metadata', addr: '0.0.0.0/0', method: 'md5' },
]

default['pacifica-integration-test']['status_fqdn'] = 'http://127.0.0.1'
default['pacifica-integration-test']['reporting_fqdn'] = 'http://127.0.0.1'
default['pacifica-integration-test']['cart_external_url'] = 'http://127.0.0.1'
