# When making a get request from a form, query string parameters are ignored.
# Instead, the parameters must be added as hidden fields. This module ensures 
# that the session id parameter is properly injected into forms.
module Galakei::SessionIdParameter::InForm
  def extra_tags_for_form(html_options)
    s = super
    if !request.cookies? && html_options["method"] == "get"
      s << session_input_tag
    end
    s
  end

  def button_to(name, options = {}, html_options = {})
    s = super
    if !request.cookies? && html_options[:method] == :get
      s.sub!("</form>",session_input_tag + "</form>".html_safe)
    end
    s
  end

  private

  def session_input_tag
    key = ::Rails.application.config.session_options[:key]
    tag(:input, :type => "hidden", :name => key, :value => request.session_options[:id])
  end
end
