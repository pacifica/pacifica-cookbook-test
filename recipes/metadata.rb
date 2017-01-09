metadata_env = {
  environment: {
    ELASTICDB_PORT: "tcp://#{elasticsearch_lb_ipaddress}:9200",
    POSTGRES_ENV_POSTGRES_DB: 'metadata',
    POSTGRES_ENV_POSTGRES_USER: 'metadata',
    POSTGRES_PORT_5432_TCP_ADDR: pgsql_ipaddress,
    POSTGRES_ENV_POSTGRES_PASSWORD: 'metadata',
  },
}
pacifica_metadata 'metadata' do
  service_opts metadata_env
end
