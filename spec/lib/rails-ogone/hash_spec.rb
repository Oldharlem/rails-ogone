require 'spec_helper'

describe RailsOgone::Hash do
  let(:instance) { described_class.new }

  it '#add_parameter' do
    instance.add_parameter 'foo', 'bar'
    expect(instance.params).to eq({ 'FOO' => 'bar' })
  end

  it '#generate' do
    allow(RailsOgone).to receive(:sha_in) { 'this is the sha-in' }
    instance.add_parameter 'foo', 'bar'
    instance.add_parameter 'bar', 'baz'
    expect(instance.generate).to eq '33800C8F9902DD147EBBFD5DB86E96F3FE754173'
  end

  it '#raw' do
    instance.add_parameter 'foo', 'bar'
    instance.add_parameter 'bar', 'baz'
    expect(instance.raw).to eq 'FOO=barBAR=baz'
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:add_parameter, :generate, :raw)
  end
end
