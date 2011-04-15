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

  def embed_style(doc, ruleset, selector)
    doc.css(selector).each do |e| 
      styles = []
      ruleset.each_declaration do |property, value, is_important|
        styles << [property,value]
      end
      StyleApplier.create(e, styles).apply!
    end
  end

  module Font
    def applied_font(property,value,style)
      return false unless %w[color font-size].include?(property)
      wrap_all_children('<span>')
      merge_style(@element.children.first, style)
    end

    def wrap_all_children(style)
      new_parent = @element.document.parse(style).first
      @element.children.each {|f| new_parent.add_child(f)}
      @element.add_child(new_parent)
    end
  end

  module BackGround
    def applied_background(property,value,style)
      return false unless property == 'background-color'
      div = Nokogiri.make("<div>")
      merge_style(div,style)
      @element.replace(div)
      div.add_child(@element)
    end
  end

  module Border
    def applied_border(property,value,style)
      return false unless %w[border border-top border-bottom].include?(property)
      color = value.split(/\s/).last.split('#').last
      thickness = value.match(/(\d+)px/)[1]
      img = Galakei::Spacer.new(color).img_tag(:height => thickness)

      case property
      when 'border'
        @element.after(img)
        @element.before(img)
      when 'border-top'
        @element.before(img)
      when 'border-bottom'
        @element.after(img)
      end
    end
  end

  class StyleApplier
    def self.create(element,styles)
      case element.name
      when /^h\d$/
        HStyleApplier.new(element, styles)
      when 'p'
        PStyleApplier.new(element, styles)
      when 'div'
        DivStyleApplier.new(element, styles)
      else
        StyleApplier.new(element,styles)
      end
    end

    def initialize(element,styles)
      @element = element
      @styles = styles
    end

    def apply!
      @styles.each do |property,value|
        style = "#{property}: #{value};"
        applied_methods = self.class.instance_methods.grep(/^applied_/)
        is_applied = applied_methods.map {|m| send(m,property,value,style)}.uniq
        if is_applied == [false] || is_applied.blank?
          merge_style(@element,style)
        end
      end
    end

    def merge_style(element,style)
      if element['style']
        element['style'] += ";" unless element['style'] =~ /;\Z/
        element['style'] += style
      else
        element["style"] = style
      end
    end
  end

  class HStyleApplier < StyleApplier
    include Border
    include BackGround
    include Font
  end

  class PStyleApplier < StyleApplier
    include BackGround
    include Font
  end

  class DivStyleApplier < StyleApplier
    include Border
  end
end
