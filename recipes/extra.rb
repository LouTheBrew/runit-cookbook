bash 'build runit' do
  cwd '/tmp/runit'
  code <<-EOH
  bash build.sh
  mv ~/rpmbuild/RPMS/*/*.rpm /tmp/runit/
  EOH
end
package '/tmp/runit/runit-2.1.2-1.el7.centos.x86_64.rpm'
