
directories = ['/etc/consul', '/opt/consul'].each do |dir|
    describe directory(dir) do
      its('mode') { should cmp '0700' }
      its('owner') { should eq 'consul' }
      its('group') { should eq 'consul' }
    end
end

describe file('/etc/consul/server.json') do
    its('mode') { should cmp '0600' }
    its('owner') { should eq 'consul' }
    its('group') { should eq 'consul' }
end

describe command('sudo cat /etc/consul/server.json | grep ui') do
   its('stdout') { should match ("\"ui\": true,") }
end

describe command('sudo cat /etc/consul/server.json | grep bootstrap') do
   its('stdout') { should match ("\"bootstrap\": false,") }
end

describe command('sudo cat /etc/consul/server.json | grep server') do
   its('stdout') { should match ("\"server\": true,") }
end

describe command('sudo cat /etc/consul/server.json | grep data_dir') do
   its('stdout') { should match ("\"data_dir\": \"/opt/consul\",") }
end

describe command('sudo cat /etc/consul/server.json | grep log_level') do
   its('stdout') { should match ("\"log_level\": \"info\",") }
end

describe command('sudo cat /etc/consul/server.json | grep enable_syslog') do
   its('stdout') { should match ("\"enable_syslog\": true,") }
end

describe command('sudo cat /etc/consul/server.json | grep https | grep 8080') do
    its('exit_status') { should eq 0 }
end
