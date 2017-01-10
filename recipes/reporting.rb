reporting_env = {
  additional_config: {
    "env[METADATA_PORT]" => "tcp://#{core_ipaddress}:8121",
    "env[POLICY_PORT]" => "tcp://#{core_ipaddress}:8181",
    "env[CART_PORT]" => "tcp://127.0.0.1:8081"
  }
}
pacifica_reporting 'reporting' do
  php_fpm_opts reporting_env
end
