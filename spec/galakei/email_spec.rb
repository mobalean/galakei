# -*- coding: utf-8 -*-
require 'spec_helper'

describe Galakei::Email do

  it "should not have h tags" do
    html_email = '<h1>Email big title</h1><h2>Second Title</h2><h6>Sixth Title</h6>'
    Galakei::Email.to_galakei_email(html_email).should =~ /^((?!h[0-9]).)*$/
  end

  it "should not have images" do
   html_email='<div><a href="http://dragonmobile.nuancemobiledeveloper.com/"><img src="http://www.mobilemonday.jp/wp-content/uploads/2011/01/NMDP.jpg" alt=""></a></div>'
    Galakei::Email.to_galakei_email(html_email).should =~ /^((?!img).)*$/
  end

  it "should not have unsupported protocols" do
   html_email='<div><a href="ftp://some.ftpsite.com/">Download warez here</a></div>'
    Galakei::Email.to_galakei_email(html_email).should =~ /^((?!ftp).)*$/
  end

  it "should have div,href,br,hr elements" do
   html_email='<div><a href="http://dragonmobile.nuancemobiledeveloper.com/"><img src="http://www.mobilemonday.jp/wp-content/uploads/2011/01/NMDP.jpg" alt=""></a></div><hr> <br><div class="register_button"><a href="http://gigs.checkin.local:3000/events/2/tickets/new?auth_token=demo">Register</a></div>'
    Galakei::Email.to_galakei_email(html_email).should =~ /(div|href|br|hr)/
  end

end
