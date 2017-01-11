cart_env = {
  environment: {
    AMQP_PORT_5672_TCP_ADDR: core_ipaddress,
    MYSQL_PORT_3306_TCP_ADDR: core_ipaddress,
    MYSQL_ENV_MYSQL_DATABASE: 'cartd',
    MYSQL_ENV_MYSQL_USER: 'cart',
    MYSQL_ENV_MYSQL_PASSWORD: 'cart',
    VOLUME_PATH: '/exports/cart',
  },
}
include_recipe 'yum-mysql-community::mysql56'
include_recipe 'build-essential'
include_recipe 'nfs'
mysql_client 'default' do
  action :create
end
directory '/exports'
directory '/exports/cart'
mount 'cart-data' do
  mount_point '/exports/cart'
  device "#{core_ipaddress}:/exports/cart"
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
  not_if { core_ipaddress.eql?('127.0.0.1') }
  ignore_failure true
  notifies :restart, 'service[cartd]'
end
pacifica_cartbackend 'cartd' do
  service_opts cart_env
end
service 'cartd' do
  action [:enable, :start]
end
