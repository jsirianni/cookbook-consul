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
describe command('sudo consul --version | grep Consul | cut -c 9-13') do
   its('stdout') { should match (/1.1.0/) }
end

# Check member status
describe command('sudo consul members') do
    its('exit_status') { should eq 0 }
end

# default-consul-0 should be the leader
describe command('sudo consul operator raft list-peers | grep default-consul-0 | cut -c 74-79') do
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
