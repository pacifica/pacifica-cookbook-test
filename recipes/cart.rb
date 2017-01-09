cart_env = {
  environment: {
    AMQP_PORT_5672_TCP_ADDR: core_ipaddress,
    MYSQL_PORT_3306_TCP_ADDR: core_ipaddress,
    MYSQL_ENV_MYSQL_DATABASE: 'cartd',
    MYSQL_ENV_MYSQL_USER: 'cart',
    MYSQL_ENV_MYSQL_PASSWORD: 'cart',
  },
}
pacifica_cartfrontend 'cartwsgi' do
  service_opts cart_env
end
