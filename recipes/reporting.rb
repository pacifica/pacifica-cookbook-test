reporting_env = {
  listen: "#{node['ipaddress']}:9001",
  additional_config: {
    "env[METADATA_PORT]" => "tcp://#{core_ipaddress}:8121",
    "env[POLICY_PORT]" => "tcp://#{core_ipaddress}:8181",
    "env[CART_PORT]" => "tcp://127.0.0.1:8081"
  }
}
pacifica_reporting 'reporting' do
  site_fqdn node['pacifica-integration-test']['reporting_fqdn']
  php_fpm_opts reporting_env
end
