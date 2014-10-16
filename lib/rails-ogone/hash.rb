module RailsOgone
  class Hash
    attr_accessor :params, :sha_in_phrase

    def initialize
      @params = {}
      @sha_in_phrase = ""
    end

    def add_parameter(key, value)
      @params[key.upcase] = value
    end

    def generate
      @params.sort.each do |key, value|
        @sha_in_phrase << "#{key.upcase}=#{value}#{RailsOgone.sha_in}"
      end

      Digest::SHA1.hexdigest(@sha_in_phrase).upcase
    end

    def raw
      @params.inject('') do |result,pair|
        result << "#{pair[0]}=#{pair[1]}"
      end
    end
  end
end
