es_endpoints = []
search(
  :node,
  node['pacifica-integration-test']['elastic_search'],
  filter_result: { ipaddress: ['ipaddress'] }
).each do |esnode|
  es_endpoints.push("#{esnode['ipaddress']}:9200")
end
pacifica_varnish 'eslb' do
  backend_hosts es_endpoints
  listen_port 9090
end
pacifica_nginx 'eslb' do
  backend_hosts es_endpoints
  listen_port 9200
  probe_url '/_cluster/health'
end
