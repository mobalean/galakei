require 'sanitize'
module Galakei::Email

  GALAKEI_EMAIL_ADDRESS_PATTERNS = [
    /^.+@(.+\.)?pdx\.ne\.jp$/,
    /^.+@ezweb\.ne\.jp$/,
    /^.+@(?:softbank\.ne\.jp|disney\.ne\.jp)$/,
    /^.+@[dhtcrknsq]\.vodafone\.ne\.jp$/,
    /^.+@jp-[dhtcrknsq]\.ne\.jp$/,
    /^.+@emnet\.ne\.jp$/,
    /^.+@docomo\.ne\.jp$/ ]

  SANITIZE_OPTIONS = {
    :elements   => %w{font blink marquee br a div hr img},
    :attributes => {'a' => ['href'],
                    'font' => ['size','color'],
                    'marquee' => ['behaviour'],
                    'hr' => ['color'],
                    'div' => ['align'],
                    'img' => ['src'],
                    },
    :protocols  => {'a' => {'href' => ['http', 'https', 'mailto']}},
    :whitespace_elements => []
  }

  TAGS_TO_PROCESS = %w{h1 h2 h3 h4 h5 h6 p}.join(',')

  def self.galakei_email_address?(email)
    GALAKEI_EMAIL_ADDRESS_PATTERNS.any?{|p| p =~ email }
  end

  def self.to_galakei_email(html_email)
    doc = Nokogiri::HTML(html_email)
    doc.css(TAGS_TO_PROCESS).each do |node|
      node.name = "div"
      node.after("<br />")
    end
    encoding = doc.meta_encoding || "UTF-8"
    res = "<html><head>"
    res << "<meta http-equiv=\"Content-type\" content=\"text/html;charset=#{encoding}\" />"
    res << "</head><body>"
    res << Sanitize.clean(doc.to_s, SANITIZE_OPTIONS)
    res << "</body></html>"
  end

end
