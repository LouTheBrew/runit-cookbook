require 'poise'
require 'chef/resource'
require 'chef/provider'

module RunitService
  class Resource < Chef::Resource
    include Poise
    provides  :runit_service
    actions   :install, :activate, :deactivate
    attribute :name, name_attribute: true, kind_of: String
    attribute :service_template, default: 'service.erb'
    attribute :log_template, default: 'log_service.erb'
    attribute :services_directory, default: '/etc/sv/'
    attribute :activated_directory, default: '/service/'
    attribute :command, default: '/tmp/dummy.sh'
    attribute :user, default: 'root'
    attribute :group, default: 'root'
    attribute :shell, default: '/bin/sh'
    attribute :mode, default: 0777
    attribute :local_cookbook, default: 'poise-runit'
  end
  class Provider < Chef::Provider
    include Poise
    provides :runit_service
    def log_path
      ::File.join(new_resource.services_directory, new_resource.name, 'log')
    end
    def common
      [new_resource.services_directory, new_resource.activated_directory].each do |dir|
        directory dir do
          recursive true
        end
      end
    end
    def action_activate
      common
      link ::File.join(new_resource.activated_directory, new_resource.name) do
        to ::File.join(new_resource.services_directory}, new_resource.name)
      end
    end
    def action_deactivate
      common
      link ::File.join(new_resource.activated_directory, new_resource.name) do
        to ::File.join(new_resource.services_directory}, new_resource.name)
        action :delete
      end
    end
    def action_install
      common
      directory ::File.join(new_resource.services_directory, new_resource.name) do
        recursive true
      end
      directory ::File.join(new_resource.services_directory, new_resource.name, 'log') do
        recursive true
      end
      template ::File.join(new_resource.services_directory, new_resource.name, 'run') do
        source new_resource.service_template
        user new_resource.user
        group new_resource.group
        variables :context => {
          :user => new_resource.user,
          :shell => new_resource.shell,
          :command => new_resource.command
        }
        sensitive true
        mode new_resource.mode
        cookbook new_resource.local_cookbook
      end
      template ::File.join(new_resource.services_directory, new_resource.name, 'log', 'run') do
        source new_resource.log_template
        user new_resource.user
        group new_resource.group
        variables :context => {
          :user => new_resource.user,
          :shell => new_resource.shell,
          :logs => self.log_path
        }
        sensitive true
        mode new_resource.mode
        cookbook new_resource.local_cookbook
      end
      self.action_activate
    end
  end
end
