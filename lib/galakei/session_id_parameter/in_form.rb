# When making a get request from a form, query string parameters are ignored.
# Instead, the parameters must be added as hidden fields. This module ensures 
# that the session id parameter is properly injected into forms.
module Galakei::SessionIdParameter::InForm
  def extra_tags_for_form(html_options)
    return super unless html_options["method"] == :get
    session_id = extract_session_id!(html_options["action"])
    session_id.blank? ? super : (super + session_input_tag(session_id)).html_safe
  end

  def button_to(name, options = {}, html_options = {})
    return super unless html_options[:method] == :get
    url = (options.is_a?(String) ? options : url_for(options))
    session_id = extract_session_id!(url)
    return super if session_id.blank?
    s = super(name, url, html_options)
    s.sub("</form>", session_input_tag(session_id) + "</form>".html_safe).html_safe
  end

  private

  # returns session id if present in url (or path) and removes it from the passed in parameter
  def extract_session_id!(url)
    url.gsub!(/#{::Rails.application.config.session_options[:key]}=([^&]+)&?/, '')
    url.chomp!('?')
    $1
  end

  def session_input_tag(session_id)
    tag(:input, :type => "hidden", :name => ::Rails.application.config.session_options[:key], :value => session_id)
  end
end
