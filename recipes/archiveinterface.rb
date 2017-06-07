pai_env = {
  environment: {
    PAI_BACKEND_TYPE: 'posix',
    PAI_PREFIX: '/mnt/archiveinterface',
  },
}
directory '/mnt/archiveinterface'
pacifica_archiveinterface 'archiveinterface' do
  service_opts pai_env
end
