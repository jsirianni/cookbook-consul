# consul
A cookbook that configures a console cluster from the ground up
https://www.consul.io/


## Goals
- Form a Consul cluster with single chef run
- Remove `--bootstrap` state without stopping or restarting the leader node, with no manual intervention
- Adding additional nodes should be automatic, a single chef role update and converge adds the nodes


## Usage
### Create a role for the cluster
```
{
  "name":"consul_main_office",
  "run_list": [
    "recipe[consul::default]"
  ],
  "default_attributes": {
    "consul": {
        "conf": {
            "datacenter": "main_office",
            "encrypt": "mlhw8wEnpHejll40nQx/4Q==",
            "retry_join": "\"[\"10.0.3.240\",\"10.0.3.241\",\"10.0.3.242\",\"10.0.3.243\",\"10.0.3.244\"]\""
        }
    }
  }
}
```
NOTE: The `encrypt` attribute should be secured with an encrypted databag, or some other form
of secret handling. This is currently not supported out of the box with this cookbook.


### Converge the initial leader node
The initial cluster leader will need to be started in `bootstap` mode. https://www.consul.io/docs/guides/bootstrapping.html.
This can be done by passing a json attribute.
```
knife bootstrap consul-0 -r 'role[consul_main_office]' \
    -j '{ "consul": { "conf": {"bootstrap": true} }}' \
    -x root \
    -P password
```

After a successful cluster formation, chef will set `node[:consul][:conf][:bootstap]`
to `false`, which will allow the cluster to choose a new leader, should a failure occur.
This will happen when chef converges again, in the future.


### Converge the initial follower nodes
Consul clusters should have at least three total nodes.
```
knife bootstrap consul-1 -r 'role[consul_main_office]' -x root -P password
knife bootstrap consul-1 -r 'role[consul_main_office]' -x root -P password
```

### Validate that the cluster formed correctly
Log into any one of the nodes
```
# Check the service
sudo systemctl status consul

# Consul will log everything to syslog
sudo tail -F /var/log/syslog

# Get list of members
consul members  

# Get list of members and their status (leader / follower)
consul operator raft list-peers
```

## Testing
The example `.kitchen.yml` configuration requires vagrant, virtualbox, bento/ubuntu16.04 box.
```
berks install
kitchen verify
```


## Todo
- Remove `bootstrap` state from initial leader after cluster formation
