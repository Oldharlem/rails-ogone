require 'rails-ogone/helper'
require 'rails-ogone/form'
require 'rails-ogone/hash'

module RailsOgone
  attr_reader :config

  def self.load!
    @config ||= YAML.load_file('config/ogone.yml')[Rails.env].symbolize_keys

    @config.each do |k,v|
      self.class.send(:define_method, k) { v }
    end
  end
end

RailsOgone.load!
