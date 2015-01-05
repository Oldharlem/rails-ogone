require 'rails/generators/base'

module Ogone
  class ConfigGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Generates config files for rails-ogone.'
    def copy_files
      say_status 'OK', 'Copying to config/ogone.yml', :yellow
      copy_file 'ogone.yml', 'config/ogone.yml'
      say_status 'OK', 'Copying to config/initializers/ogone.rb', :yellow
      copy_file 'ogone.rb', 'config/initializers/ogone.rb'
    end

    def print_manual
      say_status 'OK', 'Done.', :green
      say "\nRemember to set your PSPID and SHA-IN/OUT vars in config/ogone.yml.", :bold
    end
  end
end
