include_recipe 'chef-sugar'
include_recipe 'yum-mysql-community::mysql56'

mysql2_chef_gem 'default' do
  action :install
end
mysql_service 'default' do
  initial_root_password 'mysql'
  action [:create]
end
execute 'chcon -R system_u:object_r:mysqld_db_t:s0 /var/lib/mysql-default' do
  only_if { rhel? }
end
mysql_service 'default' do
  action [:start]
end

mysql_connection_info = {
  host: '127.0.0.1',
  socket: '/var/run/mysql-default/mysqld.sock',
  username: 'root',
  password: 'mysql',
}

{
  uniqueid: {
    provider: Chef::Provider::Database::Mysql,
    connection: mysql_connection_info,
  },
  ingest: {
    provider: Chef::Provider::Database::Mysql,
    connection: mysql_connection_info,
  },
  cartd: {
    provider: Chef::Provider::Database::Mysql,
    connection: mysql_connection_info,
  },
}.each do |dbname, data|
  database dbname.to_s do
    data.each do |attr, value|
      send(attr.to_s, value)
    end
  end
end
{
  uniqueid: {
    password: 'uniqueid',
    connection: mysql_connection_info,
    host: core_ipaddress,
    database_name: 'uniqueid',
    action: [:grant],
    provider: Chef::Provider::Database::MysqlUser,
  },
  cart: {
    password: 'cart',
    connection: mysql_connection_info,
    host: '%',
    database_name: 'cartd',
    action: [:grant],
    provider: Chef::Provider::Database::MysqlUser,
  },
  ingest: {
    password: 'ingest',
    connection: mysql_connection_info,
    host: '%',
    database_name: 'ingest',
    action: [:grant],
    provider: Chef::Provider::Database::MysqlUser,
  },
}.each do |user, data|
  database_user user.to_s do
    data.each do |attr, value|
      send(attr, value)
    end
  end
end

