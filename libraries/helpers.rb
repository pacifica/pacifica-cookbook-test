def _factory_ipaddress(role_suffix)
  def wrapper
    ret = '127.0.0.1'
    search(
      :node,
      "chef_environment:#{node.chef_environment} AND roles:pacifica_#{role_suffix}",
      filter_result: { ipaddress: ['ipaddress'] }
    ).each do |result|
      ret = result['ipaddress']
    end
    ret
  end
end

%w(
  core
  elasticsearch_lb
  elasticsearch_master
  elasticsearch_slave
  ingest
  pgsql
).each do |role_suffix|
  self.instance_variable_set("#{role_suffix}_ipaddress", _factory_ipaddress(role_suffix))
end
