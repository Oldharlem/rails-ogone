require 'rails-ogone'

describe RailsOgone::Hash do
  subject { described_class.new }

  it '#add_parameter' do
    subject.add_parameter 'foo', 'bar'
    expect(subject.params).to eq({ 'FOO' => 'bar' })
  end

  it '#generate' do
    allow(RailsOgone).to receive(:sha_in) { 'this is the sha-in' }
    subject.add_parameter 'foo', 'bar'
    subject.add_parameter 'bar', 'baz'
    expect(subject.generate).to eq '33800C8F9902DD147EBBFD5DB86E96F3FE754173'
  end

  it '#raw' do
    subject.add_parameter 'foo', 'bar'
    subject.add_parameter 'bar', 'baz'
    expect(subject.raw).to eq 'FOO=barBAR=baz'
  end

  it '#respond_to?' do
    expect(subject).to respond_to(:add_parameter, :generate, :raw)
  end
end
