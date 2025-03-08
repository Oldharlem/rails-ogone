require 'rails-ogone/helper'
require 'rails-ogone/form'
require 'rails-ogone/hash'
require 'active_support/all'

module RailsOgone
  attr_reader :config

  ROOT = File.expand_path((defined?(Rails) && Rails.root.to_s.length > 0) ? Rails.root : ENV['RAILS_ROOT'] || '.') unless defined?(ROOT)

  def self.load!
    config_file = File.join(ROOT, 'config/ogone.yml')

    if File.exist?(config_file)
      yaml_content = File.read(config_file)
      @config ||= if Gem::Version.new(RUBY_VERSION) >= Gem::Version.new('3.1.0')
                    YAML.safe_load(yaml_content, aliases: true, symbolize_names: true)[Rails.env.to_sym]
                  else
                    YAML.load_file(config_file)[Rails.env].symbolize_keys
                  end

      @config.each do |k,v|
        self.class.send(:define_method, k) { v }
      end
    end
  end
end

RailsOgone.load! if defined?(Rails) && Rails.env != 'test'
