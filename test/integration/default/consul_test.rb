# Check for services
['consul'].each do |service|
      describe service "#{service}" do
            it { should be_installed }
            it { should be_enabled }
            it { should be_running }
      end
end
