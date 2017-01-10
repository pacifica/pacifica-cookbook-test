status_env = {
  php_options: {
    "env[METADATA_PORT]" => "tcp://#{core_ipaddress}:8121",
    "env[POLICY_PORT]" => "tcp://#{core_ipaddress}:8181",
    "env[CART_PORT]" => "tcp://127.0.0.1:8081"
  }
}
pacifica_status 'status' do
  php_fpm_opts status_env
end
