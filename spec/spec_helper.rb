$:.unshift File.expand_path('../../lib', __FILE__)

require 'mobile_mo'

def env_for(device_name)
  user_agent = { 
    "Firefox" => "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.1.16) Gecko/20101130 Firefox/3.5.16",
    "Docomo SH-06A" => "DoCoMo/2.0 SH06A3(c500;TB;W24H14)" ,
    "AU W51SH" => "KDDI-SH32 UP.Browser/6.2.0.11.2.1 (GUI) MMP/2.0",
    "Vodafone 802N" => "Vodafone/1.0/V802N/NJ001/SN*************** Browser/UP.Browser/7.0.2.1.307 Profile/MIDP-2.0 Configuration/CLDC-1.1 Ext-J-Profile/JSCL-1.2.2 Ext-V-Profile/VSCL-2.0.0",
    "Softbank 709SC" => "SoftBank/1.0/709SC/SCJ001/SN*************** Browser/NetFront/3.3 Profile/MIDP-2.0 Configuration/CLDC-1.1"
  }[device_name]
  { "HTTP_USER_AGENT" => user_agent }
end 
