require 'spec_helper'

describe RailsOgone::Form do
  let(:instance) { described_class.new }

  it '#input' do
    expect(instance.input('foo', 'bar')).to eq '<input type="hidden" name="FOO" value="bar" />'
  end

  describe '#action_url' do
    it :prod do
      instance = described_class.new 'production'
      expect(instance.action_url).to eq 'https://secure.ogone.com/ncol/prod/orderstandard.asp'
    end

    it :test do
      expect(instance.action_url).to eq 'https://secure.ogone.com/ncol/test/orderstandard.asp'
    end
  end

  describe '#tag' do
    it :prod do
      instance = described_class.new 'production'
      expect(instance.tag).to eq '<form method="post" action="https://secure.ogone.com/ncol/prod/orderstandard.asp">'
    end

    it :test do
      expect(instance.tag).to eq '<form method="post" action="https://secure.ogone.com/ncol/test/orderstandard.asp">'
    end

    it :parameters do
      expect(instance.tag(class: 'test')).to eq '<form method="post" class="test" action="https://secure.ogone.com/ncol/test/orderstandard.asp">'
    end
  end

  it '#respond_to?' do
    expect(instance).to respond_to(:input, :action_url, :tag)
  end
end
