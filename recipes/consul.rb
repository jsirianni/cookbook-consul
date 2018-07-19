remote_file "/tmp/consul.zip" do
  source node[:consul][:source]
  owner  node[:consul][:user]
  group  node[:consul][:group]
  mode   "0755"
  action :create
  notifies :run, "execute[extract_consul]", :immediately
  checksum node[:consul][:sha256]
end


execute "extract_consul" do
  command "unzip -o /tmp/consul.zip -d #{node[:consul][:path]}"
  action :nothing
end


file node[:consul][:binary] do
  mode '0700'
  owner node[:consul][:user]
  group node[:consul][:group]
end
