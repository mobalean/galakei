module MobileMo::Email

  MOBILE_EMAIL_ADDRESS_PATTERNS = [
    /^.+@(.+\.)?pdx\.ne\.jp$/,
    /^.+@ezweb\.ne\.jp$/,
    /^.+@(?:softbank\.ne\.jp|disney\.ne\.jp)$/,
    /^.+@[dhtcrknsq]\.vodafone\.ne\.jp$/,
    /^.+@jp-[dhtcrknsq]\.ne\.jp$/,
    /^.+@emnet\.ne\.jp$/,
    /^.+@docomo\.ne\.jp$/ ]

  def self.mobile_email_address?(email)
    MOBILE_EMAIL_ADDRESS_PATTERNS.any?{|p| p =~ email }
  end
end
