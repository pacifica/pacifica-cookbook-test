# Pacifica Integration Test

This cookbook does the integration testing using Vagrant to test multi-node
configurations of the pacifica cookbook.

## Testing with multi node configurations

1. Make sure you have the private network up and working.
1. Start chef-zero.
```
/opt/chefdk/embedded/bin/chef-zero -H 192.168.33.1 --file-store test
```
1. Berks vendor the cookbooks
```
berks vendor test/fixtures/cookbooks
```
1. Knife upload all the stuff to chef-zero
```
cd test/fixtures
knife upload /
```
1. Vagrant up the nodes
```
vagrant up
```
