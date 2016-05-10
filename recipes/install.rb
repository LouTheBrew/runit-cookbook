# Perform installation of runit
package 'git'
runit_install 'this node' do
  action :install
end
