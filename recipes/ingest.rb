ingest_env = {
  environment: {
    BROKER_SERVER: core_ipaddress,
    MYSQL_PORT_3306_TCP_ADDR: core_ipaddress,
    UNIQUEID_SERVER: core_ipaddress,
    POLICY_SERVER: core_ipaddress,
    METADATA_SERVER: core_ipaddress,
    ARCHIVEINTERFACE_SERVER: core_ipaddress,
    MYSQL_ENV_MYSQL_DATABASE: 'ingest',
    MYSQL_ENV_MYSQL_USER: 'ingest',
    MYSQL_ENV_MYSQL_PASSWORD: 'ingest',
    VOLUME_PATH: '/exports/ingest',
    BROKER_VHOST: '/ingest',
  },
}
include_recipe 'yum-mysql-community::mysql56'
include_recipe 'build-essential'
include_recipe 'nfs'
mysql_client 'default' do
  action :create
end
directory '/exports'
directory '/exports/ingest'
mount 'ingest-data' do
  mount_point '/exports/ingest'
  device "#{core_ipaddress}:/exports/ingest"
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
  not_if { core_ipaddress.eql?('127.0.0.1') }
  ignore_failure true
  notifies :restart, 'service[ingest]'
end
pacifica_ingestfrontend 'ingest' do
  service_opts ingest_env
end
service 'ingest' do
  action [:enable, :start]
end
