require 'spec_helper'
require "nokogiri"

describe Galakei::DocomoCss::Stylesheet do
  context "simple stylesheet" do
    before do
      parser = CssParser::Parser.new
      parser.add_block!(<<-EOD)
        span {
          color: red;
        }
      EOD
      @stylesheet = described_class.new(parser)
    end
    it "should apply style to matching element" do
      doc = Nokogiri::HTML.fragment("<span>foo</span>")
      @stylesheet.apply(doc)
      doc.to_s.should == %q{<span style="color: red;">foo</span>}
    end
    it "should not apply style to non-matching element" do
      doc = Nokogiri::HTML.fragment("<p>foo</p>")
      @stylesheet.apply(doc)
      doc.to_s.should == %q{<p>foo</p>}
    end
  end
  
  context "stylesheet with multiple styles" do
    before do
      parser = CssParser::Parser.new
      parser.add_block!(<<-EOD)
        div {
          background-color: red;
        }
        
        .alC {
          text-align: center
        }
      EOD
      @stylesheet = described_class.new(parser)
    end

    it "should apply style to element that matches one style" do
      doc = Nokogiri::HTML.fragment("<div class='alC'>foo</span>")
      @stylesheet.apply(doc)
      doc.to_s.should == %q{<div class="alC" style="background-color: red;text-align: center;">foo</div>}
    end
  end
  context "stylesheet with pseudo style" do
    before do
      parser = CssParser::Parser.new
      parser.add_block!(<<-EOD)
        a:link      { color: red; }
        a:focus     { color: green; }
        a:visited   { color: blue; }
      EOD
      @stylesheet = described_class.new(parser)
    end

    it "should add to head" do
      doc = Nokogiri::HTML(<<-EOD)
        <html>
          <head></head>
          <body><a href="/">foo</a></body>
        </html>
      EOD
      @stylesheet.apply(doc)
      doc.at("//a").to_s.should == %q{<a href="/">foo</a>}
      expected = <<-EOD
<style type="text/css">
<![CDATA[
a:link { color: red; }
a:focus { color: green; }
a:visited { color: blue; }
]]>
</style>
EOD
      doc.at("/html/head/style").to_s.strip.should == expected.strip
    end
  end

  ((1..6).map {|i| "h#{i}"} + %w[p]).each do |tag|
    context "style applied to #{tag}" do
      before do
        parser = CssParser::Parser.new
        parser.add_block!(<<-EOD)
          #{tag}.color { color: red; }
          #{tag}.fontsize { font-size: x-small; }
          #{tag}.backgroundcolor { background-color: blue; }
        EOD
        @stylesheet = described_class.new(parser)
      end

      it "should wrap children in span for color" do
        doc = Nokogiri::HTML("<#{tag} class='color'>foo</#{tag}>")
        @stylesheet.apply(doc)
        doc.at("//#{tag}").to_s.should == %Q{<#{tag} class="color"><span style="color: red;">foo</span></#{tag}>}
      end

      it "should wrap children in span for font-size" do
        doc = Nokogiri::HTML("<#{tag} class='fontsize'>foo</#{tag}>")
        @stylesheet.apply(doc)
        doc.at("//#{tag}").to_s.should == %Q{<#{tag} class="fontsize"><span style="font-size: x-small;">foo</span></#{tag}>}
      end

      it "should wrap multiple children in single span" do
        doc = Nokogiri::HTML("<#{tag} class='fontsize'>foo<br />bar</#{tag}>")
        @stylesheet.apply(doc)
        doc.at("//#{tag}").to_s.should == %Q{<#{tag} class="fontsize"><span style="font-size: x-small;">foo<br>bar</span></#{tag}>}
      end

      it "should wrap element in div for background-color" do
        doc = Nokogiri::HTML("<#{tag} class='backgroundcolor'>foo</#{tag}>")
        @stylesheet.apply(doc)
        doc.at("//div").to_s.should == %Q{<div style="background-color: blue;"><#{tag} class="backgroundcolor">foo</#{tag}></div>}
      end
    end
  end

  context "style applied to child of h1" do
    before do
      parser = CssParser::Parser.new
      parser.add_block!(<<-EOD)
        h1 span { color: red; }
      EOD
      @stylesheet = described_class.new(parser)
    end

    it "should not apply style to single h1" do
      doc = Nokogiri::HTML("<h1>foo</h1>")
      @stylesheet.apply(doc)
      doc.at("//h1").to_s.should == %q{<h1>foo</h1>}
    end

    it "should apply style to neseted element" do
      doc = Nokogiri::HTML("<h1><span>foo</span></h1>")
      @stylesheet.apply(doc)
      doc.at("//h1").to_s.should == %q{<h1><span style="color: red;">foo</span></h1>}
    end
  end

  context 'border css applied to div' do
    before do
      parser = CssParser::Parser.new
      parser.add_block!(<<-EOD)
        div { border: 1px solid #000000; }
      EOD
      @stylesheet = described_class.new(parser)
      @doc = Nokogiri::HTML("<div>test</div>")
      @stylesheet.apply(@doc)
      @img = %q[<img src="/galakei/spacer/000000" width="100%" height="1">]
    end

    it do
      div = @doc.at("//div")
      div.previous_sibling.to_s.should == @img 
      div.next_sibling.to_s.should == @img 
    end
  end
end
