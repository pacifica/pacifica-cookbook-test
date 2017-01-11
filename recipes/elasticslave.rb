# do nothing as we just need the attributes
node.default['elasticsearch']['configure']['configuration']['discovery.zen.ping.unicast.hosts'] = elasticsearch_master_ipaddress
