require 'spec_helper'

describe 'nginx::default' do
  #subject { ChefSpec::Runner.new.converge(described_recipe) }

  # Write quick specs using `it` blocks with implied subjects
  # it { should do_something('...') }

  # Write full examples using the `expect` syntax
  #it 'does something' do
  #  expect(subject).to do_something('...')
  #end

  # Use an explicit subject
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'install nginx' do
    expect(chef_run).to install_package('nginx')
  end
  
  it 'writes the nginx conf template' do
    expect(chef_run).to create_template('/etc/nginx/conf.d/default.conf')
  end

  it 'restart the service' do
    expect(chef_run).to start_service('nginx')
  end

end
