template '/tmp/dummy.sh' do
  source 'dummy_service.erb'
  mode 0777
end
runit_install '/service/'
runit_service 'dummy' do
  command '/tmp/dummy.sh'
end
