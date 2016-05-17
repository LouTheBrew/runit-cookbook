# runit-cookbook
A cookbook to control runit

attributes/default.rb
======================
- default[:poise_runit][:service][:directory]
- directory var exists to specify directory where services should exist

runit_install
=====================
- installs runit according to reasonable defaults
- creates an /etc/init.d/runit service by default and adds it to chkconfig but does not start it
- activating runit with chefs service interface works
```
service 'runit' do
  action :start
end
```
```
runit_install node[:poise_runit][:service][:directory]
```

runit_service
====================
- create a runit service
- create action automatically tries to activate the service
- services are activated by links from the inactive directory to the active directory
