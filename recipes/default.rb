package node[:consul][:packages] do
  action :install
end

include_recipe "consul::user"
include_recipe "consul::consul"
include_recipe "consul::config"
include_recipe "consul::systemd"
