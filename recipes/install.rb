directory node[:poise_runit][:service][:directory] do
  recursive true
end
runit_install node[:poise_runit][:service][:directory]
