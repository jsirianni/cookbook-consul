# Configure the unit file
template node[:consul][:systemd_unit_file] do
  source "consul.service.erb"
  owner node[:consul][:user]
  group node[:consul][:group]
  mode "0644"
  notifies :run, "execute[reload_systemd]", :immediately
end


# Reload systemd if required
execute "reload_systemd" do
  command "systemctl daemon-reload"
  action :nothing
  notifies :reload, "service[consul]", :delayed
  # notifies :reload, "service[consul]", :immediately
end


# Enable and run consul
service "consul" do
  action [:enable, :start]
end
