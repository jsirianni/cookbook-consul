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
