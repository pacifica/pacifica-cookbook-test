%w(
  core
  elasticsearch_lb
  elasticsearch_master
  elasticsearch_slave
  ingest
  pgsql
).each do |role_suffix|
  unless self.class.public_method_defined?("#{role_suffix}_ipaddresses")
    self.class.send(:define_method, "#{role_suffix}_ipaddresses") do
      ret = []
      search(
        :node,
        "chef_environment:#{node.chef_environment} AND roles:pacifica_#{role_suffix}",
        filter_result: { ipaddress: ['ipaddress'] }
      ).each do |result|
        ret.push(result['ipaddress'])
      end
      ret
    end
  end
  unless self.class.public_method_defined?("#{role_suffix}_ipaddress")
    self.class.send(:define_method, "#{role_suffix}_ipaddress") do
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
end
