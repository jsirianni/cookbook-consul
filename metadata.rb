name 'consul'
maintainer 'Joseph Sirianni'
maintainer_email 'joseph.sirianni88@gmail.com'
license 'BSD 2-Clause License'
description 'Installs/Configures a Consul cluster'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.2'
chef_version '>= 12.14' if respond_to?(:chef_version)
issues_url 'https://github.com/jsirianni/cookbook-consul/issues'
source_url 'https://github.com/jsirianni/cookbook-consul'
