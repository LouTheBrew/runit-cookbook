include_recipe 'build-essential'
template '/tmp/dummy.sh' do
  source 'dummy_service.erb'
  mode 0777
end
runit_install 'this node' do
  action :install
end
runit_service 'core001' do
  command '/tmp/dummy.sh'
end
bash "run" do
  code 'runsvdir -P /etc/sv/ log: &'
end
