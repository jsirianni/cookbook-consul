# Read node attributes
node = json("/tmp/kitchen/dna.json").params

# Archive should exist
describe file('/tmp/consul.zip') do
    its('mode') { should cmp '0755' }
    its('owner') { should eq 'consul' }
    its('group') { should eq 'consul' }
end

# Binary should exist in the install dir
describe file('/usr/local/bin/consul') do
    its('mode') { should cmp '0700' }
    its('owner') { should eq 'consul' }
    its('group') { should eq 'consul' }
end

# Verify version 1.1.0
describe command("sudo /usr/local/bin/consul --version -http-addr #{node['consul']['conf']['bind_addr']}:8500 | grep Consul | cut -c 9-13") do
   its('stdout') { should match (/1.2.1/) }
end

# Check member status
describe command("sudo /usr/local/bin/consul members -http-addr #{node['consul']['conf']['bind_addr']}:8500") do
    its('exit_status') { should eq 0 }
end

# default-consul-0 should be the leader
describe command("sudo /usr/local/bin/consul operator raft list-peers -http-addr #{node['consul']['conf']['bind_addr']}:8500 | grep default-consul-0 | cut -c 74-79") do
    its('exit_status') { should eq 0 }
    its('stdout') { should match (/leader/) }
end

# Cluster communication
describe port(8301) do
  it { should be_listening }
end

describe port(8302) do
  it { should be_listening }
end

# Web interface
describe port(8500) do
  it { should be_listening }
end
