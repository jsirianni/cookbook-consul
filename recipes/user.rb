group node[:consul][:group] do
  action :create
end

user node[:consul][:user] do
  shell  '/sbin/nologin'
  gid     node[:consul][:group]
  system  true
  manage_home false
  action :create
end
