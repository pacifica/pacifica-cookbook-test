proxy_env = {
  environment: {
    METADATA_PORT: "tcp://#{core_ipaddress}:8121",
    ARCHIVEI_PORT: "tcp://#{archive_ipaddress}:8080",
  },
}
pacifica_proxy 'proxy' do
  service_opts proxy_env
end
