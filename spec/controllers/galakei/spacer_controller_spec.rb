require 'spec_helper'

describe Galakei::SpacerController do
  before do
    get :create, :color => '#000000', :format => :gif
  end
  subject { response }
  its(:content_type) { should eq 'image/gif' }
end
