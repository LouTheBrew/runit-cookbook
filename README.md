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
- This is the most basic example
```
runit_install node[:poise_runit][:service][:directory]
```

runit_service
====================
- create a runit service
- create action automatically tries to activate the service
- services are activated by links from the inactive directory to the active directory
- this is the most basic example, this service will start at boot, be kept up, logged to log/current and reside in /service (active) and /etc/sv (inactive)
```
runit_service 'useless_sleep' do
  command 'sleep 10'
end
```
- You can disable a service like this
```
runit_service 'useless_sleep' do
  action :deactivate
end
```
- You may enable it once more without running any additional installation steps with
```
runit_service 'useless_sleep' do
  action :deactivate
end
```
