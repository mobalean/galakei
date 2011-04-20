require 'spec_helper'

describe Galakei::Spacer do
  context "#000000" do
    subject { described_class.new("#000000") }
    it { subject.img_tag.should == %Q[<img src='/galakei/spacer/000000' width='100%' height='1'>] }
    it { subject.create.should_not be_nil }
  end
  %w[000000 aqua black blue fuchsia gray green lime maroon navy olive orange purple red silver teal white yellow].each do |s|
    context s do
      subject { described_class.new(s) }
      it { subject.img_tag.should == %Q[<img src='/galakei/spacer/#{s}' width='100%' height='1'>] }
      it { subject.create.should_not be_nil }
    end
  end 
end
