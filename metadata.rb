name 'pacifica-integration-test'
maintainer 'David Brown'
maintainer_email 'dmlb2000@gmail.com'
license 'all_rights'
description 'Installs/Configures pacifica-integration-test'
long_description 'Installs/Configures pacifica-integration-test'
version '0.1.0'

issues_url 'https://github.com/pacifica/pacifica-cookbook-test/issues' if respond_to?(:issues_url)
source_url 'https://github.com/pacifica/pacifica-cookbook-test' if respond_to?(:source_url)

depends 'pacifica'
depends 'postgresql', '< 6.0.0'
depends 'database', '>= 6.1.0'
depends 'yum-mysql-community', '>= 2.0.0'
depends 'mysql2_chef_gem', '>= 1.1.0'
depends 'mysql', '>= 8.2.0'
depends 'chef-sugar'
