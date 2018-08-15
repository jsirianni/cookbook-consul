default[:consul][:packages] = 'unzip'

# User and group
default[:consul][:user]  = "consul"
default[:consul][:group] = "consul"


# Path to binary / arguments as a string
default[:consul][:path]   = "/usr/local/bin"
default[:consul][:binary] = "/usr/local/bin/consul"
default[:consul][:mode]   = "-server"


# Source URL
default[:consul][:source] = "https://releases.hashicorp.com/consul/1.2.1/consul_1.2.1_linux_amd64.zip"
default[:consul][:sha256] = "e4146334be453146890023303da3e0c815669e108a18fb7d742745df3414a31a"


# Config directories
default[:consul][:conf][:base]         = "/etc/consul/consul.d"


# Config params
default[:consul][:conf][:ui]         = false
default[:consul][:conf][:server]     = true
default[:consul][:conf][:beta_ui]    = 0     # set to 1 to enable
default[:consul][:conf][:bootstrap]  = false # NOTE: Set to true on a single node, during cluster formation
default[:consul][:conf][:datacenter] = "default" # NOTE: Override w/ role
default[:consul][:conf][:encrypt]    = ""        # NOTE: Override w/ role
default[:consul][:conf][:log_level]  = "info"
default[:consul][:conf][:syslog]     = "true"
default[:consul][:conf][:data_dir]   = "/opt/consul"
default[:consul][:conf][:retry_join] = '["10.1.10.1"]'     # NOTE: Override w/ role # NOTE: Same as startjoin but will retry
default[:consul][:conf][:retry_join_wan] = '[]'
default[:consul][:conf][:bind_addr]  = '0.0.0.0' # Must be overridden if instance has multiple network interfaces
default[:consul][:conf][:api_port]   = '8500' # default port

# See the docuentation to understand acl
# https://www.consul.io/docs/agent/options.html#acl_datacenter
# This cookbook will default to deny all, and only allow what is
# specifically prohibited.
default[:consul][:conf][:acl][:datacenter]     = "default" # NOTE: Override w/ role
default[:consul][:conf][:acl][:default_policy] = "deny"    # NOTE: Override w/ role # NOTE: consul will default to allow
default[:consul][:conf][:acl][:down_policy]    = "extend-cache"  # NOTE: Override w/ role
default[:consul][:conf][:acl][:master_token]   = "sosecure"  # NOTE: Override w/ role
default[:consul][:conf][:acl][:agent_token]    = "sosecure"  # NOTE: Override w/ role


# Systemd
default[:consul][:systemd_unit_file] = "/etc/systemd/system/consul.service"


# tls
default[:consul][:conf][:tls][:dir]       = "/etc/consul/cert"
default[:consul][:conf][:tls][:ca]        = "/etc/consul/cert/ca.crt"
default[:consul][:conf][:tls][:cert_file] = "/etc/consul/cert/consul.crt"
default[:consul][:conf][:tls][:key_file]  = "/etc/consul/cert/consul.key"
default[:consul][:conf][:tls][:verify_incoming] = true
default[:consul][:conf][:tls][:verify_outgoing] = true
