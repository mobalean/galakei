require 'spec_helper'

describe MobileMo::Middleware::ContentType do
  describe "from Docomo SH-06A" do
    before { @env = env_for("Docomo SH-06A") }
    describe "content type is text/html" do
      before { @app = MobileMo::Middleware::ContentType.new(mock("app", :call => [ :status, {"Content-Type" => "text/html"}, :response ])) }
      it("should return content type application/xhtml+xml") do
        @app.call(@env)[1].should == {"Content-Type"=>"application/xhtml+xml"}
      end
    end
    describe "content type is text/html; charset=utf-8" do
      before { @app = MobileMo::Middleware::ContentType.new(mock("app", :call => [ :status, {"Content-Type" => "text/html; charset=utf-8"}, :response ])) }
      it("should return content type application/xhtml+xml; charset=utf-8") do
        @app.call(@env)[1].should == {"Content-Type"=>"application/xhtml+xml; charset=utf-8"}
      end
    end
    describe "content type is image/png" do
      before { @app = MobileMo::Middleware::ContentType.new(mock("app", :call => [ :status, {"Content-Type" => "image/png"}, :response ])) }
      it("should not change content type") do
        @app.call(@env)[1].should == {"Content-Type"=>"image/png"}
      end
    end
    describe "304 response" do
      before { @app = MobileMo::Middleware::ContentType.new(mock("app", :call => [ 304, {}, :response ])) }
      it("should not change content type") do
        @app.call(@env)[1].should == {}
      end
    end
  end

  describe "from AU W51SH" do
    before { @env = env_for("AU W51SH") }
    describe "content type is text/html" do
      before { @app = MobileMo::Middleware::ContentType.new(mock("app", :call => [ :status, {"Content-Type" => "text/html"}, :response ])) }
      it("should not change content type") do
        @app.call(@env)[1].should == {"Content-Type"=>"text/html"}
      end
    end
  end
end
