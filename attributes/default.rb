default[:consul][:packages] = 'unzip'

# User and group
default[:consul][:user]  = "consul"
default[:consul][:group] = "consul"


# Path to binary / arguments as a string
default[:consul][:path]   = "/usr/local/bin"
default[:consul][:binary] = "/usr/local/bin/consul"
default[:consul][:mode]   = "-server"


# Source URL
default[:consul][:source] = "https://releases.hashicorp.com/consul/1.0.7/consul_1.0.7_linux_amd64.zip"


# Config directories
default[:consul][:conf][:base] = "/etc/consul/conf.d"
default[:consul][:conf][:bootstrapdir] = "/etc/consul/conf.d/bootstrap"
default[:consul][:conf][:serverdir]    = "/etc/consul/conf.d/server"
default[:consul][:conf][:clientdir]    = "/etc/consul/conf.d/client"


# Config params
default[:consul][:conf][:datacenter] = "default" # NOTE: Override w/ role
default[:consul][:conf][:encrypt]    = ""        # NOTE: Override w/ role
default[:consul][:conf][:log_level]  = "info"
default[:consul][:conf][:syslog]     = "true"
default[:consul][:conf][:data_dir]   = "/opt/consul"
default[:consul][:conf][:retry_join] = '["10.1.10.1"]'     # NOTE: Override w/ role # NOTE: Same as startjoin but will retry


# Systemd
default[:consul][:systemd_unit_file] = "/etc/systemd/system/consul.service"
