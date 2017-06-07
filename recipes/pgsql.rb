require 'ipaddr'
include_recipe 'postgresql::ruby'
include_recipe 'postgresql::server'
include_recipe 'postgresql::config_pgtune'

node.default['postgresql']['pg_hba'] = [
  {
    type: 'local',
    db: 'all',
    user: 'postgres',
    method: 'ident',
  },
  {
    type: 'local',
    db: 'all',
    user: 'all',
    method: 'ident',
  },
  {
    type: 'host',
    db: 'all',
    user: 'all',
    addr: '127.0.0.1/32',
    method: 'md5',
  },
  {
    type: 'host',
    db: 'all',
    user: 'all',
    addr: '::1/128',
    method: 'md5',
  },
]

postgresql_connection_info = {
  host: '127.0.0.1',
  port: node['postgresql']['config']['port'],
  username: 'postgres',
  password: 'postgres',
}

{
  status: {
    provider: Chef::Provider::Database::Postgresql,
    connection: postgresql_connection_info,
  },
  reporting: {
    provider: Chef::Provider::Database::Postgresql,
    connection: postgresql_connection_info,
  },
  metadata: {
    provider: Chef::Provider::Database::Postgresql,
    connection: postgresql_connection_info,
  },
}.each do |dbname, data|
  database dbname.to_s do
    data.each do |attr, value|
      send(attr.to_s, value)
    end
  end
end
{
  status: {
    password: 'status',
    database_name: 'status',
    provider: Chef::Provider::Database::PostgresqlUser,
    connection: postgresql_connection_info,
    action: [:create, :grant],
  },
  reporting: {
    password: 'reporting',
    database_name: 'reporting',
    provider: Chef::Provider::Database::PostgresqlUser,
    connection: postgresql_connection_info,
    action: [:create, :grant],
  },
  metadata: {
    password: 'metadata',
    database_name: 'metadata',
    provider: Chef::Provider::Database::PostgresqlUser,
    connection: postgresql_connection_info,
    action: [:create, :grant],
  },
}.each do |user, data|
  database_user user.to_s do
    data.each do |attr, value|
      send(attr, value)
    end
  end
  node_ipaddress = IPAddr.new "#{node['ipaddress']}/24"
  node.default['postgresql']['pg_hba'].push(
    type: 'host',
    db: data[:database_name],
    user: user.to_s,
    addr: "#{node_ipaddress}/24",
    method: 'md5'
  )
end
