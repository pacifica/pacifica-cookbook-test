uniqueid_env = {
  environment: {
    MYSQL_PORT_3306_TCP_ADDR: core_ipaddress,
    MYSQL_ENV_MYSQL_DATABASE: 'uniqueid',
    MYSQL_ENV_MYSQL_USER: 'uniqueid',
    MYSQL_ENV_MYSQL_PASSWORD: 'uniqueid',
  },
}
pacifica_uniqueid 'uniqueid' do
  service_opts uniqueid_env
end
