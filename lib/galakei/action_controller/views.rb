module Galakei
  module ActionController
    module Views
      def self.included(klass)
        klass.before_filter :append_galakei_views, :if => :galakei?
      end

      private

      def append_galakei_views
        logger.debug("appending galakei views")
        prepend_view_path(::Rails.root.join('app','views.galakei'))
      end
    end
  end
end
