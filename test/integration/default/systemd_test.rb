# Read node attributes
node = json("/tmp/kitchen/dna.json").params

describe service "consul" do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
end

describe file('/etc/systemd/system/consul.service') do
    its('mode') { should cmp '0644' }
    its('owner') { should eq 'consul' }
    its('group') { should eq 'consul' }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep Requires') do
   its('stdout') { should match (/Requires=network-online.target/) }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep After') do
   its('stdout') { should match (/After=network-online.target/) }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep User') do
   its('stdout') { should match (/User=consul/) }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep Group') do
   its('stdout') { should match (/Group=consul/) }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep Restart') do
   its('stdout') { should match (/Restart=on-failure/) }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep ExecStart | cut -c 11-43') do
   its('stdout') { should match ("/usr/local/bin/consul agent -bind") }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep ExecStart | cut -c 56-87') do
   its('stdout') { should match ("-config-dir=/etc/consul/consul.d") }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep ExecReload') do
   its('stdout') { should match ("ExecReload=/usr/local/bin/consul reload -http-addr #{node['consul']['conf']['bind_addr']}:8500") }
end

describe command('sudo cat /etc/systemd/system/consul.service | grep KillSignal') do
   its('stdout') { should match (/KillSignal=SIGINT/) }
end
