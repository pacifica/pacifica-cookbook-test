policy_env = {
  environment: {
    METADATA_PORT: "tcp://#{core_ipaddress}:8121",
  },
}
pacifica_policy 'policy' do
  service_opts policy_env
end
