require 'spec_helper'
require 'action_controller'

describe Galakei::ActionController::ContentType do
  before :each do
    klass = Class.new(ActionController::Base) do
      include Galakei::ActionController::ContentType
    end
    @controller = klass.new
    @request = mock("request")
    @response = mock("response")
    @controller.stub!(:request).and_return(@request)
    @controller.stub!(:response).and_return(@response)
  end
  describe "from docomo" do
    before { @request.should_receive(:docomo?).and_return(true) }
    describe "content type is text/html" do
      before { @response.should_receive(:content_type).and_return("text/html") }
      it("should require xhtml content type") do
        @controller.should be_xhtml_content_type_required
      end
    end
    describe "content type is image/png" do
      before { @response.should_receive(:content_type).and_return("image/png") }
      it("should not change content type") do
        @controller.should_not be_xhtml_content_type_required
      end
    end
    describe "304 response" do
      before { @response.should_receive(:content_type).and_return(nil) }
      it("should not change content type") do
        @controller.should_not be_xhtml_content_type_required
      end
    end
  end
  describe "from non docomo" do
    before { @request.should_receive(:docomo?).and_return(false) }
    it("should not change content type") do
      @controller.should_not be_xhtml_content_type_required
    end
  end
end
