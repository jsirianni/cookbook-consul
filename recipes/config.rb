dirs = [node[:consul][:conf][:base],
  node[:consul][:conf][:bootstrapdir],
  node[:consul][:conf][:serverdir],
  node[:consul][:conf][:clientdir]]


dirs.each do |dir|
  directory dir do
    recursive true
    action :create
    owner node[:consul][:user]
    group node[:consul][:group]
  end
end


# Create bootstrap config
template "#{node[:consul][:conf][:bootstrapdir]}/config.json" do
  source "bootstrap.json.erb"
  owner node[:consul][:user]
  group node[:consul][:group]
  mode "0600"
  notifies :restart, "service[consul]", :delayed
  action :create
end


# Create server config
template "#{node[:consul][:conf][:serverdir]}/config.json" do
  source "server.json.erb"
  owner node[:consul][:user]
  group node[:consul][:group]
  mode "0600"
  notifies :restart, "service[consul]", :delayed
  action :create
end
