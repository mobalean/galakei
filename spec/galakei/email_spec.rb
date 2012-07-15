# -*- coding: utf-8 -*-
require 'spec_helper'

MSG=<<EOT
<html>
<head>
<meta http-equiv="Content-type" content="text/html;charset=UTF-8" />
<title> This is mytitle </title>
</head>
<body bgcolor="#FFFF00">
<h1>A first level heading
</h1
<h3>A third level heading
</h3>
<blink> A BLINKING TITLE
</blink>
        A table
<table>
<tr><td>Cell top left</td><td>Cell top right</td></tr>
<tr><td>Cell bot left</td><td>Cell bot right</td></tr>
</table>
<marquee behaviour="scroll"> HELLO mailworld I'm a marquee
</marquee>
<div align="left">
左側
</div>
<hr color="#0000FF">
<div align="center">
ど真ん中
</div>
<div style="text-align:center;">
</div>
<hr color="#FF0000">
<div align="right">
右側
</div>
こんにちは世界！ばあばばばあ
</body>
<br/>
<font size=4 color="#009900">
GREEEEEEN
</font>
<img src="http://someurl.com/someimage.png"/>
<a href="http://dragonmobile.nuancemobiledeveloper.com/"><img src="cid:image-attachment-id" alt=""/></a>this was an image
<br/>
This is <img src="http://someurl.com/someimage.png" alt="イメジー"/>...
And now, <a href="ftp://some.ftpsite.com/">Downloadz youz warez herez!</a>
</html>
EOT

describe Galakei::Email do
  let(:sanitized_mail){ Galakei::Email.to_galakei_email(MSG) }

  it "should have a html, head, meta and body" do
    sanitized_mail.should =~ /html.*head.*meta.*body/m
  end

  it "should have supported tags and styles" do
    sanitized_mail.should =~ /<div align=/m
    sanitized_mail.should =~ /<hr color=/m
    sanitized_mail.should =~ /<font size=.*color=/m
    sanitized_mail.should =~ /<br>/m
    sanitized_mail.should =~ /<blink>/m
    sanitized_mail.should =~ /<marquee behaviour=/m
    sanitized_mail.should =~ /<a href=/m
  end
  
  it "should not have h and table tags" do
    sanitized_mail.should_not =~ /<h[0-9]>/
    sanitized_mail.should_not =~ /<table>/
  end

  it "should handle images" do
    sanitized_mail.should =~ /<img src=.*cid/m
    sanitized_mail.should_not =~ /<img src=.*http/m
    sanitized_mail.should match("This is イメジー...")
  end

  it "should not have unsupported protocols" do
    sanitized_mail.should_not =~ /ftpsite/
  end

  it "should not have title" do
    sanitized_mail.should_not =~ /mytitle/
  end 

end
