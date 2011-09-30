# encoding: UTF-8
require 'spec_helper'

shared_examples_for "convertable zenkaku" do |body|
  it 'should be converted' do
    @response.stub!(:body).and_return(body)
    @response.should_receive(:body=).with(/ﾒｲﾝｶﾞｷﾞ漢字ひらがな。/)
    @filter.filter
  end
end

shared_examples_for "unconvertable zenkaku" do |body|
  it 'should not be converted' do
    @response.stub!(:body).and_return(body)
    @response.should_receive(:body=).with(/メインガギ漢字ひらがな。/)
    @filter.filter
  end
end

describe Galakei::Filter::Hankaku do
  before do
    @filter = described_class.new
    @filter.controller = mock("controller")
    @request = mock("request")
    @response = mock("response")
    @filter.controller.stub!(:request).and_return(@request)
    @filter.controller.stub!(:response).and_return(@response)
  end

  it_should_behave_like "convertable zenkaku", "<div id='hankaku'>メインガギ漢字ひらがな。</div>"
  it_should_behave_like "unconvertable zenkaku", "<textarea id='hankaku'>メインガギ漢字ひらがな。</textarea>"
  it_should_behave_like "unconvertable zenkaku", "<input id='hankaku' value='メインガギ漢字ひらがな。'></input>"
  it_should_behave_like "convertable zenkaku", "<input type='submit' id='hankaku' value='メインガギ漢字ひらがな。'></input>"
  it_should_behave_like "convertable zenkaku", "<input type='button' id='hankaku' value='メインガギ漢字ひらがな。'></input>"

  it 'should convert long vowel' do
    @response.stub!(:body).and_return("プロフィール")
    @response.should_receive(:body=).with(/ﾌﾟﾛﾌｨｰﾙ/)
    @filter.filter
  end
end
