module Galakei
  module ActionController
    module Helper
      def self.included(klass)
        klass.helper_method :galakei?
      end

      protected

      def galakei?
        request.galakei?
      end
    end
  end
end
