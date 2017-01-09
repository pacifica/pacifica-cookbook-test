def module_name
  self.class.to_s.split("::").first
end
%w(
  core
  elasticsearch_lb
  elasticsearch_master
  elasticsearch_slave
  ingest
  pgsql
).each do |role_suffix|
  str_ruby_method = %Q{
    def #{role_suffix}_ipaddress
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
  }
  module_name.method_eval(str_ruby_method)
end
