$:.unshift File.expand_path('../../lib', __FILE__)

require 'galakei'
require File.expand_path(File.dirname(__FILE__) + "/app/fake")
require 'rspec/rails'

def env_for_firefox
  { "HTTP_USER_AGENT" => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.16) Gecko/20101130 Firefox/3.5.16" }
end

def env_for_docomo_1_0
  { "HTTP_USER_AGENT" => "DoCoMo/2.0 SH06A3(c500;TB;W24H14)"  }
end

def env_for_au_6_2
  { "HTTP_USER_AGENT" => "KDDI-SH32 UP.Browser/6.2.0.11.2.1 (GUI) MMP/2.0" }
end

def env_for_au_7_2
  { "HTTP_USER_AGENT" => "KDDI-SA3B UP.Browser/6.2_7.2.7.1.K.1.3.101 (GUI) MMP/2.0" }
end

def env_for_vodafone
  { "HTTP_USER_AGENT" => "Vodafone/1.0/V802N/NJ001/SN*************** Browser/UP.Browser/7.0.2.1.307 Profile/MIDP-2.0 Configuration/CLDC-1.1 Ext-J-Profile/JSCL-1.2.2 Ext-V-Profile/VSCL-2.0.0" }
end

def env_for_softbank
  { "HTTP_USER_AGENT" => "SoftBank/1.0/709SC/SCJ001/SN*************** Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1" }
end 
