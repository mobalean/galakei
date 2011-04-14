require 'spec_helper'

describe Galakei::Spacer do
  describe 'initialize' do
    it 'should can initialize' do
      expect {
        described_class.new('#000000')
      }.to_not raise_error
    end
  end 

  describe 'output img_tag' do
    subject { described_class.new('#000000').img_tag }
    it { should == %q[<img src='/galakei/spacer/000000' width='100%' height='1'>] }
  end

  describe 'create image binary' do
    subject { described_class.new('#000000').create }
    it { should_not be_nil }
  end
end
