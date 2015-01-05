module RailsOgone
  class Form
    attr_reader :hash

    def initialize(environment = 'test')
      @environment = environment == 'production' ? 'prod' : 'test'
      @form_fields = {}
      @hash = RailsOgone::Hash.new
    end

    def action_url
      "https://secure.ogone.com/ncol/#{@environment}/orderstandard.asp"
    end

    def input(name, value)
      value = (value.to_f * 100).to_i if name.downcase == 'amount'
      @form_fields[name] = value
      @hash.add_parameter name, value
      html_string = "<input type=\"hidden\" name=\"%s\" value=\"%s\" />" % [name.upcase, value]
      ActiveSupport::SafeBuffer.new html_string
    end

    def tag(options = {})
      options[:action] = action_url

      form_attributes = options.inject('') do |attributes, pair|
        attributes << " #{pair[0]}=\"#{pair[1]}\""
      end

      output = "<form method=\"post\"#{form_attributes}>"
      ActiveSupport::SafeBuffer.new output
    end
  end
end
