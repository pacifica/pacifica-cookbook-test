reporting_env = {
  listen: "#{node['ipaddress']}:9001",
  additional_config: {
    'env[METADATA_PORT]' => "tcp://#{core_ipaddress}:8121",
    'env[POLICY_PORT]' => "tcp://#{core_ipaddress}:8181",
    'env[CART_PORT]' => 'tcp://127.0.0.1:8081',
  },
}
reporting_config_vars = {
  base_url: node['pacifica-integration-test']['reporting_fqdn'],
  timezone: 'UTC',
}
reporting_database_vars = {
  db_host: pgsql_ipaddress,
  db_user: 'reporting',
  db_pass: 'reporting',
  db_name: 'reporting',
  db_driver: 'postgre',
  cache_on: 'FALSE',
  cache_dir: '',
}
pacifica_reporting 'reporting' do
  php_fpm_opts reporting_env
  ci_prod_config_vars reporting_config_vars
  ci_prod_database_vars reporting_database_vars
end
