require 'spec_helper'

describe 'eldus-runit::install' do
  describe file('/service/') do
    it { should exist }
  end
end
