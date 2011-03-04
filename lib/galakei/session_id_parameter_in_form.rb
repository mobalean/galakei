module Galakei
  module SessionIdParameterInForm
    def extra_tags_for_form(html_options)
      s = super
      if html_options["method"] == "get"
        key = ::Rails.application.config.session_options[:key]
        s << tag(:input, :type => "hidden", :name => key, :value => request.session_options[:id])
      end
      s
    end
  end
end
