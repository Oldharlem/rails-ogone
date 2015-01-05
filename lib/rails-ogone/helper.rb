module RailsOgone
  module Helper
    def ogone_form_tag(options = {}, &block)
      @ogone_form = RailsOgone::Form.new Rails.env
      output = @ogone_form.tag options
      output << @ogone_form.input('PSPID', RailsOgone.pspid)
      output << capture(@ogone_form, &block)
      output << @ogone_form.input('SHASIGN', @ogone_form.hash.generate)
      output << "\n</form>".html_safe
      output.html_safe
    end
  end
end
