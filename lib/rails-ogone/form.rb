module RailsOgone
  class Form
    attr_reader :hash

    def initialize(environment = 'test')
      @environment = environment == 'production' ? 'prod' : 'test'
      @form_fields = {}
      @hash = RailsOgone::Hash.new
    end

    def action_url(options = {})
      options.reverse_merge!(utf8: false)
      page = options[:utf8] ? 'orderstandard_utf8' : 'orderstandard'
      "https://secure.ogone.com/ncol/#{@environment}/#{page}.asp"
    end

    def input(type, name, value)
      value = (value.to_f * 100).to_i if name.downcase == 'amount'
      @form_fields[name] = value
      @hash.add_parameter name, value
      html_string = "<input type=\"%s\" name=\"%s\" value=\"%s\" />" % [type, name.upcase, value]
      ActiveSupport::SafeBuffer.new html_string
    end

    def radio_button(name, value)
      input 'radio', name, value
    end

    def tag(options = {})
      options.reverse_merge!(utf8: false)
      options[:action] = action_url(utf8: options[:utf8])

      form_attributes = options.except(:utf8).inject('') do |attributes, pair|
        attributes << " #{pair[0]}=\"#{pair[1]}\""
      end

      output = "<form method=\"post\"#{form_attributes}>"
      ActiveSupport::SafeBuffer.new output
    end

    def hidden_field(name, value)
      input 'hidden', name, value
    end
  end
end
