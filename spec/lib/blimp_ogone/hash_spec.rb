require 'spec_helper'

describe BlimpOgone::Hash do
  let(:instance) { described_class.new }

  it '#add_parameter' do
    instance.add_parameter 'foo', 'bar'
    expect(instance.params).to eq({ 'FOO' => 'bar' })
  end

  it '#generate' do
    instance.add_parameter 'foo', 'bar'
    instance.add_parameter 'bar', 'baz'
    expect(instance.generate).to eq '4F4EC7F53F309DB473D36FAC9D81849D810199BB'
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
