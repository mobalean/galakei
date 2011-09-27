# encoding: UTF-8
require File.expand_path(File.dirname(__FILE__) + '/acceptance_helper')

class AuMailInterceptorMailer < ActionMailer::Base
  include ActionView::Helpers::TagHelper
  include ActionView::Helpers::AssetTagHelper

  def ticket(mail_address)
    attachments.inline['ticket-qr-code.gif'] = "blob"
    mail(:from => "info@mobalean.com",
         :to => mail_address,
         :subject => "subjectline") do |format|
      format.text { render :text => "HELLO world" }
      format.html do
        render :inline => image_tag(attachments['ticket-qr-code.gif'].url,
                                    :alt => 'QR-code ticket')
      end
    end
  end

  def controller
    self
  end
end

describe 'email' do
  let(:email){ ActionMailer::Base.deliveries.last }
  before { AuMailInterceptorMailer.ticket(mail_address).deliver }

  context "RFC compliant multipart mail" do
    let(:mail_address) { "info@mobalean.com" }
    it { email.content_type.should match /^multipart\/related/ }
    it { email.content_type_parameters.should include("boundary") }
    it { email.parts.size.should == 2 }
    it { email.parts.map(&:mime_type).sort.should == ["image/gif", "multipart/alternative"] }
  end

  context "au html multipart mail" do
    let(:mail_address) { "hihihi@ezweb.ne.jp" }
    it { email.content_type.should match /^multipart\/alternative/ }
    it { email.content_type_parameters.should include("boundary") }
    it { email.parts.size.should == 3 }
    it { email.parts.map(&:mime_type).sort.should == ["image/gif", "text/html", "text/plain" ] }
 end

end
