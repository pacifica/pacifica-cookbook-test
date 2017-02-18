uploader_env = {
  'BROKER_SERVER' => core_ipaddress,
  'MYSQL_PORT_3306_TCP_ADDR' => core_ipaddress,
  'POLICY_SERVER' => core_ipaddress,
  'BROKER_VHOST' => '/uploader',
}
uploader1_env = { 'environment' => uploader_env.clone }
uploader2_env = { 'environment' => uploader_env.clone }
uploader1_env['environment']['BROKER_VHOST'] = '/uploader1'
uploader2_env['environment']['BROKER_VHOST'] = '/uploader2'
include_recipe 'nfs'
directory '/exports'
directory '/exports/uploader'
mount 'uploader-data' do
  mount_point '/exports/uploader'
  device "#{core_ipaddress}:/exports/uploader"
  fstype 'nfs'
  options 'rw'
  action [:mount, :enable]
  not_if { core_ipaddress.eql?('127.0.0.1') }
  ignore_failure true
  notifies :restart, 'service[uploader1]'
  notifies :restart, 'service[uploader2]'
end
pacifica_uploaderfrontend 'uploader1' do
  service_opts uploader_env
end
pacifica_uploaderfrontend 'uploader2' do
  service_opts uploader_env
end
%w(uploader1 uploader2).each do |uploader_part|
  file "/opt/#{uploader_part}/source/UploaderConfig.json" do
    content data_bag_item('pacifica', uploader_part)['config'].to_json
  end
end
service 'uploader1' do
  action [:enable, :start]
end
service 'uploader2' do
  action [:enable, :start]
end

