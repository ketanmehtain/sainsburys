require 'serverspec'
set :backend, :exec

describe 'nginx::default' do
  describe package('nginx') do
    it { should be_installed }
  end

  describe file('/etc/nginx/conf.d/default.conf') do
    it { should be_a_file }
  end

  describe service('nginx') do
    it { should be_enabled.with_level(3) }
  end

  describe service('nginx') do
    it { should be_running }
  end
end
