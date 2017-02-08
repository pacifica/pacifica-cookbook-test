status_env = {
  listen: "#{node['ipaddress']}:9000",
  additional_config: {
    "env[METADATA_PORT]" => "tcp://#{core_ipaddress}:8121",
    "env[POLICY_PORT]" => "tcp://#{core_ipaddress}:8181",
    "env[CART_PORT]" => "tcp://127.0.0.1:8081",
    "env[CART_DOWNLOAD_PORT]" => node['pacifica-integration-test']['cart_external_url']
  }
}
status_config_vars = {
  base_url: node['pacifica-integration-test']['status_fqdn'],
  timezone: 'US/Pacific',
}
status_database_vars = {
  db_host: pgsql_ipaddress,
  db_user: 'status',
  db_pass: 'status',
  db_name: 'status',
  db_driver: 'postgres',
  cache_on: 'FALSE',
  cache_dir: '',
}
pacifica_status 'status' do
  php_fpm_opts status_env
  ci_prod_config_vars status_config_vars
  ci_prod_database_vars status_database_vars
end
