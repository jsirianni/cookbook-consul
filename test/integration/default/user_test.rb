describe user('consul') do
  it { should exist }
  its('group') { should eq 'consul' }
  its('shell') { should eq '/sbin/nologin' }
end
