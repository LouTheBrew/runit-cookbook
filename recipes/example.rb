# This is an example of a non-default runit install which showcases the variables needed to be changed in order to achieve isolation of installs
# Defaults for the default installation in install.rb reflect runit standards
user 'runit'
group 'runit'
directory '/my/service/' do
  recursive true
end
runit_install '/my/service/' do
  init_service_name 'myrunit'
  runsvdir_start_path '/my/runsvdir-start'
  runit_src_directory '/my/src/'
  inactive_directory '/my/inactive/'
  bin_dir '/my/'
  user 'runit'
  group 'runit'
end
template '/tmp/dummy.sh' do
  source 'dummy_service.erb'
  cookbook 'eldus-runit'
  mode 0777
end
runit_service 'dummy' do
  command '/tmp/dummy.sh'
  activated_directory '/my/service/'
  services_directory '/my/inactive/'
end
