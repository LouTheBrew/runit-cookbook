require 'poise'
require 'chef/resource'
require 'chef/provider'

module Runit
  class Resource < Chef::Resource
    include Poise
    provides  :runit_install
    actions   :install
    attribute :name, name_attribute: true, kind_of: String
    attribute :runit_package_repository, required: true, default: 'https://github.com/LouTheBrew/runit.git'
    attribute :runit_package_name, required: true, default: 'runit'
    attribute :runit_package_directory, required: true, default: '/opt/'
  end
  class Provider < Chef::Provider
    include Poise
    provides :runit_install
    def common
      directory "#{new_resource.runit_package_directory}#{new_resource.runit_package_name}" do
        recursive true
      end
    end
    def action_install
      nil
    end
  end
end
