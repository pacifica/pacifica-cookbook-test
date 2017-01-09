status_env = {
  environment: {
    METADATA_PORT: core_ipaddress,
    POLICY_PORT: core_ipaddress
  },
}
pacifica_status 'status' do
  service_opts status_env
end
