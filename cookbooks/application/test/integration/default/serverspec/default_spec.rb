require 'serverspec'
set :backend, :exec

describe 'application::default' do
	describe file('/opt/app.go') do
		it { should be_a_file }
	end

	describe command('ls /usr/local') do
		its(:stdout) { should match /go/ }
	end

  describe service('app') do
    it { should be_enabled.with_level(3) }
  end

  describe service('app') do
    it { should be_running }
  end
end
