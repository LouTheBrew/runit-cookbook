include_recipe 'build-essential'
template '/tmp/dummy.sh' do
  source 'dummy_service.erb'
  mode 0777
end
runit_install '/service/'
runit_service 'core001'
