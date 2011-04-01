class Capybara::Driver::RackTestWithUserAgent < Capybara::Driver::RackTest
  def initialize(app, user_agent)
    super(app)
    @user_agent = user_agent
  end
  private
  def env
    super.tap {|env| env['HTTP_USER_AGENT'] = @user_agent }
  end
end

Capybara.register_driver :docomo do |app|
  Capybara::Driver::RackTestWithUserAgent.new(app, "DoCoMo/2.0 P903i(c100;TB;W24H12)")
end

Capybara.register_driver :au do |app|
  Capybara::Driver::RackTestWithUserAgent.new(app, "KDDI-CA32 UP.Browser/6.2.0.7.3.129 (GUI) MMP/2.0")
end

Capybara.register_driver :softbank do |app|
  Capybara::Driver::RackTestWithUserAgent.new(app, "SoftBank/1.0/943SH/SHJ001/SN*************** Browser/NetFront/3.5 Profile/MIDP-2.0 Configuration/CLDC-1.1")
end