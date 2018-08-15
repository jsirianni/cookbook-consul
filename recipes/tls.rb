directory node[:consul][:conf][:tls][:dir] do
  recursive true
  action :create
  owner node[:consul][:user]
  group node[:consul][:group]
  mode "0700"
end

# Enforce file permissions but do not change the file
# Chef will create an empty file if not exists, which will
# cause fault to fail if tsl is enabled.
#
# NOTE: set `node[:consul][:conf][:tls][:tls_disable] = true`
# to verify that the service is working. Then manually add the cert
# and key to the cert directory.
#
[node[:consul][:conf][:tls][:ca], node[:consul][:conf][:tls][:cert], node[:consul][:conf][:tls][:key]].each do |cert_file|
  file cert_file do
    owner node[:consul][:user]
    group node[:consul][:group]

    # consul should read but never write
    mode '0400'

    # enforce permissions but never overwrite the cert
    action :create
  end
end
