module Galakei
  module HelperMethods
    def self.included(klass)
      klass.helper_method :galakei?
    end

    protected

    def galakei?
      request.galakei?
    end
  end
end
