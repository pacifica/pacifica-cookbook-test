uploader_env = {
  BROKER_SERVER: core_ipaddress,
  MYSQL_PORT_3306_TCP_ADDR: core_ipaddress,
  POLICY_SERVER: core_ipaddress,
  BROKER_VHOST: '/uploader',
}
uploader1_env = { environment: uploader_env.clone }
uploader2_env = { environment: uploader_env.clone }
uploader1_env[:environment][:BROKER_VHOST] = '/uploader1'
uploader2_env[:environment][:BROKER_VHOST] = '/uploader2'
include_recipe 'nfs'
directory '/exports'
directory '/exports/uploader'
# there's a bit of chicken and the egg problem here
# The core_ipaddress shows up before the core server
# knows to allow these hosts to mount
mount 'uploaderd-data' do
  mount_point '/exports/uploader'
  device "#{core_ipaddress}:/exports/uploader"
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
  not_if { core_ipaddress.eql?('127.0.0.1') }
  ignore_failure true
  notifies :restart, 'service[uploader1d]'
  notifies :restart, 'service[uploader2d]'
end
pacifica_uploaderbackend 'uploader1d' do
  service_opts uploader1_env
end
pacifica_uploaderbackend 'uploader2d' do
  service_opts uploader2_env
end
%w(uploader1 uploader2).each do |uploader_part|
  file "/opt/#{uploader_part}d/source/UploaderConfig.json" do
    content data_bag_item('pacifica', uploader_part)['config'].to_json
  end
end
service 'uploader1d' do
  action [:enable, :start]
end
service 'uploader2d' do
  action [:enable, :start]
end
