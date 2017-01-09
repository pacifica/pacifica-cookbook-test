reporting_env = {
  environment: {
    METADATA_PORT: core_ipaddress,
    POLICY_PORT: core_ipaddress
  },
}
pacifica_reporting 'reporting' do
  service_opts reporting_env
end
