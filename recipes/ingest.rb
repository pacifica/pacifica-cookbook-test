ingest_env = {
  environment: {
    BROKER_SERVER: core_ipaddress,
    MYSQL_PORT_3306_TCP_ADDR: core_ipaddress,
    MYSQL_ENV_MYSQL_DATABASE: 'ingest',
    MYSQL_ENV_MYSQL_USER: 'ingest',
    MYSQL_ENV_MYSQL_PASSWORD: 'ingest',
  },
}
pacifica_ingestfrontend 'default' do
  service_opts ingest_env
end
