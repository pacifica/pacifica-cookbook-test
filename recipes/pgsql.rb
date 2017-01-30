include_recipe 'postgresql::ruby'
include_recipe 'postgresql::server'
include_recipe 'postgresql::config_pgtune'

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
end
