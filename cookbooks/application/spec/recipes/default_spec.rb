require 'spec_helper'

describe 'application::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'download the go language package' do
    expect(chef_run).to  create_remote_file(File.join(Chef::Config[:file_cache_path], 'go1.6.linux-amd64.tar.gz'))
      .with_owner('root')
      .with_mode('0644')
  end

  it 'extract go tar file' do
    expect(chef_run).to run_bash('untar_golang')
  end

  it 'copy file aap.go' do
    expect(chef_run).to create_cookbook_file('/opt/app.go')
      .with_owner('root')
      .with_group('root')
      .with_mode('0644')
  end

  it 'copy file run.sh' do
    expect(chef_run).to create_cookbook_file('/opt/run.sh')
  end

  it 'copy file aap.go' do
    expect(chef_run).to run_execute('app-run')
  end

  it 'create init file' do
    expect(chef_run).to create_cookbook_file('/etc/init.d/app')
  end

  it 'add to chkconfig' do
    expect(chef_run).to run_execute('app-init')
  end

  it 'start the service' do
    expect(chef_run).to start_service('app')
  end

end
