directory node[:eldus_runit][:service][:directory] do
  recursive true
end
runit_install node[:eldus_runit][:service][:directory]
