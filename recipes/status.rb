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
  ci_prod_template_vars status_config_vars
end
