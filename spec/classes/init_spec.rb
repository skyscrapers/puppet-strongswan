require 'spec_helper'
describe 'strongswan' do
  context 'with default values for all parameters' do
    it { should contain_class('strongswan') }
  end
end
