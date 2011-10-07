# coding: utf-8
=begin
For galakei, zenkaku katakana such as カタカナ will be converted to hankaku like ｶﾀｶﾅ automatically when rendering html. This is standard practice, as zenkaku katakana taxes up too much screen space.
=end
class Galakei::Filter::Hankaku < Galakei::Filter::Base
  # :stopdoc:
  zenkaku = %w(ガ ギ グ ゲ ゴ ザ ジ ズ ゼ ゾ ダ ヂ ヅ デ ド バ ビ ブ ベ ボ パ ピ プ ペ ポ ヴ ア イ ウ エ オ カ キ ク ケ コ サ シ ス セ ソ タ チ ツ テ ト ナ ニ ヌ ネ ノ ハ ヒ フ ヘ ホ マ ミ ム メ モ ヤ ユ ヨ ラ リ ル レ ロ ワ ヲ ン ャ ュ ョ ァ ィ ゥ ェ ォ ッ ー)
  hankaku = %w(ｶﾞ ｷﾞ ｸﾞ ｹﾞ ｺﾞ ｻﾞ ｼﾞ ｽﾞ ｾﾞ ｿﾞ ﾀﾞ ﾁﾞ ﾂﾞ ﾃﾞ ﾄﾞ ﾊﾞ ﾋﾞ ﾌﾞ ﾍﾞ ﾎﾞ ﾊﾟ ﾋﾟ ﾌﾟ ﾍﾟ ﾎﾟ ｳﾞ ｱ ｲ ｳ ｴ ｵ ｶ ｷ ｸ ｹ ｺ ｻ ｼ ｽ ｾ ｿ ﾀ ﾁ ﾂ ﾃ ﾄ ﾅ ﾆ ﾇ ﾈ ﾉ ﾊ ﾋ ﾌ ﾍ ﾎ ﾏ ﾐ ﾑ ﾒ ﾓ ﾔ ﾕ ﾖ ﾗ ﾘ ﾙ ﾚ ﾛ ﾜ ｦ ﾝ ｬ ｭ ｮ ｧ ｨ ｩ ｪ ｫ ｯ ｰ)
  MAPPING = zenkaku.zip(hankaku)

  def condition?
    galakei? && response.content_type =~ %r{text/html|application/xhtml\+xml}
  end

  def filter
    doc = Nokogiri::HTML(response.body)
    response.body = convert_text_content(doc).to_xhtml
  end

  def convert_text_content(doc)
    doc.children.each do |e|
      if e.kind_of?(Nokogiri::XML::Text) && e.parent.node_name != "textarea"
        e.content = zenkaku_to_hankaku(e.content)
      elsif e.node_name == "input" && %w[submit button].include?(e["type"])
        e["value"] = zenkaku_to_hankaku(e["value"])
      else
        convert_text_content(e)
      end
    end
    doc
  end

  def zenkaku_to_hankaku(s)
    MAPPING.each {|from, to| s.gsub!(from, to) }
    s
  end
end
