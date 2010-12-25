module Galakei
  module ActionController
    module Base
      def self.included(klass)
        klass.before_filter :append_galakei_views, :if => :galakei?
        klass.helper_method :galakei?
      end

      protected

      def galakei?
        request.galakei?
      end

      private

      def append_galakei_views
        logger.debug("appending galakei views")
        prepend_view_path(::Rails.root.join('app','views.galakei'))
      end
    end
  end
end
