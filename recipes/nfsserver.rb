include_recipe 'nfs::server'
link '/exports' do
  to '/mnt'
end
directory '/exports/uploader'
directory '/exports/ingest'
directory '/exports/cart'
(ingest_ipaddresses + worker_ipaddresses + uploader_ipaddresses).each do |ipaddr|
  nfs_export "/exports" do
    network "#{ipaddr}/32"
    writeable true
    sync true
    options ['no_root_squash']
  end
end
