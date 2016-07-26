include_recipe 'eldus-runit::install'
# Uncomment this to run alternative installation example
#include_recipe 'eldus-runit::example'
template '/tmp/dummy.sh' do
  source 'dummy_service.erb'
  cookbook 'eldus-runit'
end
runit_service 'test' do
  command 'bash /tmp/dummy.sh'
end
