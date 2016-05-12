require 'poise'
require 'chef/resource'
require 'chef/provider'

module RunitInstall
  class Resource < Chef::Resource
    include Poise
    provides  :runit_install
    actions   :install
    attribute :essentials_cookbook, default: 'build-essential'
    attribute :name, name_attribute: true, kind_of: String
    attribute :runit_repository, required: true, default: 'https://github.com/LouTheBrew/runit.git'
    attribute :runit_src_directory, required: true, default: '/opt/runit/src/'
    attribute :shell_bin, required: true, default: 'bash'
    attribute :bin_dir, default: '/bin'
    attribute :install_deps, default: true
    attribute :deps, default: %w{glibc-static git}
    attribute :env, default: {:vars => [
      {:key => 'SVDIR', :value => '/service/'},
      {:key => 'SVWAIT', :value => '7'}
    ]}
    attribute :implement_init_service, default: true
    attribute :implement_systemd_service, default: true
  end
  class Provider < Chef::Provider
    include Poise
    provides :runit_install
    def deps
      new_resource.deps.each do |pkg|
        package pkg
      end
    end
    def common
      directory new_resource.runit_src_directory do
        recursive true
      end
      yield
    end
    def action_install
      include_recipe new_resource.essentials_cookbook
      if new_resource.install_deps
        deps
      end
      common do
        git new_resource.runit_src_directory do
          repository new_resource.runit_repository
        end
        bash "build runit move binaries to #{new_resource.bin_dir}" do
          cwd new_resource.runit_src_directory
          code <<-EOH
          package/install
          mv command/* #{new_resource.bin_dir}
          EOH
          not_if do ::File.exist?('command/') end
        end
        if new_resource.implement_init_service
          nil
        end
        if new_resource.implement_systemd_service
          nil
        end
      end
    end
  end
end
