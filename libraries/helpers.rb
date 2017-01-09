module PacificaIntegrationCookbook
  def _factory_ipaddress(search)
    def wrapped
      ret = '127.0.0.1'
      search(
        :node,
        "chef_environment:#{node.chef_environment} AND roles:pacifica_#{search}",
        filter_result: { ipaddress: ['ipaddress'] }
      ).each do |result|
        ret = result['ipaddress']
      end
      ret
    end
    wrapped
  end
  module PacificaIntegrationHelpers
  end
  %w(
    core
    elasticsearch_lb
    elasticsearch_master
    elasticsearch_slave
    ingest
    pgsql
  ).each do |role_suffix|
    ruby_method = %q{
      #{role_suffix}_ipaddress = _factory_ipaddress(#{role_suffix})
    }
    PacificaIntegrationHelpers.module_eval(ruby_method)
  end
end
