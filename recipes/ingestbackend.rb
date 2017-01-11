ingest_env = {
  environment: {
    BROKER_SERVER: core_ipaddress,
    MYSQL_PORT_3306_TCP_ADDR: core_ipaddress,
    MYSQL_ENV_MYSQL_DATABASE: 'ingest',
    MYSQL_ENV_MYSQL_USER: 'ingest',
    MYSQL_ENV_MYSQL_PASSWORD: 'ingest',
    VOLUME_PATH: '/exports/ingest',
  },
}
include_recipe 'yum-mysql-community::mysql56'
include_recipe 'build-essential'
include_recipe 'nfs'
mysql_client 'default' do
  action :create
end
mount 'ingest-data' do
  mount_point '/exports/ingest'
  device "#{core_ipaddress}:/exports/ingest"
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
  not_if { core_ipaddress.eql?('127.0.0.1') }
  notifies :restart, 'service[ingest]'
end
pacifica_ingestbackend 'ingestd' do
  service_opts ingest_env
end
service 'ingestd' do
  action [:enable, :start]
end
