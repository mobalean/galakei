require "css_parser"
require 'nokogiri'

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

  def to_s
    @parsed_stylesheet.to_s
  end

  private

  def embed_style(doc, ruleset, selector)
    doc.css(selector).each do |e| 
      styles = []
      ruleset.each_declaration do |property, value, is_important|
        styles << [property,value]
      end
      apply_element_specific_style(e, styles)
    end
  end

  def apply_element_specific_style(element, styles)
    style_adapters = case element.name
    when /^h\d$/
      [BorderAdapter, BackGroundAdapter, FontAdapter]
    when 'p'
      [BackGroundAdapter, FontAdapter]
    when 'td'
      [FontAdapter]
    when 'div'
      [BorderAdapter]
    else
      []
    end
    styles.each do |property,value|
      applicable_styles = style_adapters.find_all {|s| s.apply?(property)}
      applicable_styles = [ CssInliner ] if applicable_styles.empty?
      applicable_styles.each {|s| s.apply(element, property, value) }
    end
  end

  class GenericAdapter
    private
    def self.merge_style(element,property, value)
      style = "#{property}: #{value};"
      if element['style']
        element['style'] += ";" unless element['style'] =~ /;\Z/
        element['style'] += style
      else
        element["style"] = style
      end
    end
  end

  class CssInliner < GenericAdapter
    def self.apply(element, property, value)
      merge_style(element,property,value)
    end
  end

  class FontAdapter < GenericAdapter
    def self.apply?(property)
      %w[color font-size].include?(property)
    end

    def self.apply(element, property, value)
      wrap_all_children(element, '<span>')
      merge_style(element.children.first, property, value)
    end

    private

    def self.wrap_all_children(element, tag)
      new_parent = element.document.parse(tag).first
      element.children.each {|f| new_parent.add_child(f)}
      element.add_child(new_parent)
    end
  end

  class BackGroundAdapter < GenericAdapter
    def self.apply?(property)
      property == 'background-color'
    end

    def self.apply(element, property, value)
      div = Nokogiri.make("<div>")
      merge_style(div,property,value)
      element.replace(div)
      div.add_child(element)
    end
  end

  class BorderAdapter < GenericAdapter
    def self.apply?(property)
      %w[border border-top border-bottom].include?(property)
    end

    def self.apply(element, property,value)
      color = value.split(/\s/).last.split('#').last
      thickness = value.match(/(\d+)px/)[1]
      img = Galakei::Spacer.img_tag(:color => color, :height => thickness)

      case property
      when 'border'
        element.after(img)
        element.before(img)
      when 'border-top'
        element.before(img)
      when 'border-bottom'
        element.after(img)
      end
    rescue => err
      Rails.logger.warn("could not insert spacer gif: #{err}")
    end
  end
end
