module MobileMo
  module ActionController
    module Base
      def self.included(klass)
        klass.before_filter :append_mobile_views, :if => :is_mobile_device?
        klass.helper_method :is_mobile_device?
      end

      protected

      def is_mobile_device?
        request.is_mobile_device?
      end

      private

      def append_mobile_views
        logger.debug("appending mobile views")
        prepend_view_path(::Rails.root.join('app','views.mobile'))
      end
    end
  end
end
