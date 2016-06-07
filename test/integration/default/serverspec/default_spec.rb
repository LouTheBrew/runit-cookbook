require 'spec_helper'

describe 'poise-runit::install' do
  describe file('/service/') do
    it { should exist }
  end
end
