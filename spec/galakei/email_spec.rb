# -*- coding: utf-8 -*-
require 'spec_helper'

describe Galakei::Email do

  it "should not have h tags" do
    html_email = '<h1>Email big heading</h1><h2>Second heading</h2><h6>Sixth heading</h6>'
    Galakei::Email.to_galakei_email(html_email).should_not =~ /<h[0-9]>/
  end

  it "should have images with cid" do
    html_email='<a href="http://dragonmobile.nuancemobiledeveloper.com/"><img src="cid:image-attachment-id" alt=""/></a>this was an image'
    Galakei::Email.to_galakei_email(html_email).should =~ /img.*cid/m
  end

  it "should not have unsupported protocols" do
    html_email='<a href="ftp://some.ftpsite.com/">Downloadz youz warez herez</a> Monsieur'
    Galakei::Email.to_galakei_email(html_email).should_not =~ /ftpsite/
  end

  it "should have a html, head, meta and body" do
    html_email='<html><head><meta http-equiv="Content-type" content="text/html;charset=UTF-8"" ><title>Document X</title><head><body>I am a body!</body></html>'
    Galakei::Email.to_galakei_email(html_email).should =~ /html.*head.*meta.*body/m
  end

  it "should have div,href,br,hr elements" do
    html_email='<div align="center"><a href="http://dragonmobile.nuancemobiledeveloper.com/"><img src="http://www.mobilemonday.jp/wp-content/uploads/2011/01/NMDP.jpg" alt=""></a></div><hr color="blue"> <br><div class="register_button"><a href="http://gigs.checkin.local:3000/events/2/tickets/new?auth_token=demo">Register</a></div>'
    Galakei::Email.to_galakei_email(html_email).should =~ /div(.*)align(.*)href(.*)hr(.*)blue(.*)br/m
  end

  it "should allow font, blink and marquee elements" do
    html_email='<div align="center"><font size="2" color="red">NEWS FLASH</font><blink>plink plink plink the nineties!</blink><marquee behaviour="scroll">This is corn!</marquee></div>'
    Galakei::Email.to_galakei_email(html_email).should =~ /font(.*)size(.*)color(.*)blink(.*)marquee(.*)behaviour/m
  end

end
