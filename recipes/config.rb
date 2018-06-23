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
template "#{node[:consul][:conf][:base]}/server.json" do
  source "server.json.erb"
  owner node[:consul][:user]
  group node[:consul][:group]
  mode "0600"
  notifies :reload, "service[consul]", :delayed
  action :create
end
