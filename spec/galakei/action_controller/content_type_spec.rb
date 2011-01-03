require 'spec_helper'

describe Galakei::Filter::ContentType do
  before :each do
    @filter = Galakei::Filter::ContentType.new
    @controller = mock("controller")
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
        @filter.should be_after_condition(@controller)
      end
    end
    describe "content type is image/png" do
      before { @response.should_receive(:content_type).and_return("image/png") }
      it("should not change content type") do
        @filter.should_not be_after_condition(@controller)
      end
    end
    describe "304 response" do
      before { @response.should_receive(:content_type).and_return(nil) }
      it("should not change content type") do
        @filter.should_not be_after_condition(@controller)
      end
    end
  end
  describe "from non docomo" do
    before { @request.should_receive(:docomo?).and_return(false) }
    it("should not change content type") do
      @filter.should_not be_after_condition(@controller)
    end
  end
end
