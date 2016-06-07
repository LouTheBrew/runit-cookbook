require 'spec_helper'

describe 'runit-cookbook::install' do
  describe file('/service/') do
    it { should exist }
  end
end

#describe 'runit-cookbook::example' do
#  %w{/my/service/ /my/inactive/}.each do |dir|
#    describe file(dir) do
#      it { should exist }
#    end
#  end
#end
