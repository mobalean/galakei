require "css_parser"

class Galakei::DocomoCss::Stylesheet
  def initialize(parsed_stylesheet)
    @parsed_stylesheet = parsed_stylesheet
  end

  def apply(doc)
    pseudo_styles = []
    @parsed_stylesheet.each_rule_set do |ruleset|
      ruleset.each_selector do |selector, declarations_string, specificity|
        if selector =~ /a:(link|focus|visited)/
          pseudo_styles << "#{selector} { #{declarations_string} }"
        else
          embed_style(doc, ruleset, selector)
        end
      end
    end
    unless pseudo_styles.empty?
      doc.at("/html/head").add_child(<<-EOD)
<style type="text/css">
<![CDATA[
#{pseudo_styles.join("\n")}
]]>
</style>
EOD
    end
    doc
  end

  private

  def merge_style(e, s)
    if e["style"] 
      e['style'] += ";" unless e['style'] =~ /;\Z/
        e['style'] += s
    else
      e["style"] = s
    end
  end

  def wrap_all_children(e, s)
    new_parent = e.document.parse(s).first
    e.children.each {|f| new_parent.add_child(f)}
    e.add_child(new_parent)
  end

  def add_image_line_to_top(e, property, value)
    color = value.split(/\s/).last.split('#').last
    img =  Galakei::Spacer.gif(color)
    e.before(img)
  end

  def add_image_line_to_bottom(e, property, value)
    color = value.split(/\s/).last.split('#').last
    img =  Galakei::Spacer.gif(color)
    e.after(img)
  end

  def style_for_div(e,property,value)
    case property
    when 'border'
      add_image_line_to_top(e, property, value)
      add_image_line_to_bottom(e, property, value)
    when 'border-top'
      add_image_line_to_top(e, property, value)
    when 'border-bottom'
      add_image_line_to_bottom(e, property, value)
    else
      merge_style(e, "#{property}: #{value}")
    end
  end

  def embed_style(doc, ruleset, selector)
    doc.css(selector).each do |e| 
      ruleset.each_declaration do |property, value, is_important|
        s = "#{property}: #{value};"
        if selector =~ /^(h\d|p)[^\s]*$/
          if %w[color font-size].include?(property)
            wrap_all_children(e, '<span>')
            merge_style(e.children.first, s)
          elsif %w[background-color].include?(property)
            div = Nokogiri.make("<div>")
            merge_style(div, s)
            e.replace(div)
            div.add_child(e)
          else
            merge_style(e, s)
          end
        elsif selector =~ /^div[^\s]*$/
          style_for_div(e,property,value)
        else
          merge_style(e, s)
        end
      end
    end
  end
end
