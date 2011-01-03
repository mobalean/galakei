module Galakei
  module Filter
    class Views
      def self.inject(klass)
        klass.before_filter self.new, :if => :galakei?
      end

      def before(controller)
        controller.logger.debug("appending galakei views")
        controller.prepend_view_path(::Rails.root.join('app','views.galakei'))
      end
    end
  end
end
