dirs = [
  node[:consul][:conf][:base],
  node[:consul][:conf][:data_dir]
]


# Directories should only be readable by the consul user and root
dirs.each do |dir|
  directory dir do
    recursive true
    action :create
    owner node[:consul][:user]
    group node[:consul][:group]
    mode "0700"
  end
end


# Create server config
template "#{node[:consul][:conf][:base]}/consul.json" do
  if node[:consul][:conf][:server] == true
    source "server.json.erb"
  else
    source "agent.json.erb"
  end
  owner node[:consul][:user]
  group node[:consul][:group]
  mode "0600"
  notifies :restart, "service[consul]", :delayed
  action :create
end
