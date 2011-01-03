module Galakei
  module Filter
    class Base
      attr_accessor :controller

      def self.inject(klass)
        this_class = self
        klass.after_filter self, :if => lambda {|c| this_class.after_condition?(c) }
      end

      def self.after(controller)
        @instance ||= self.new
        @instance.controller = controller
        @instance.after
      end

      def self.after_condition?(controller)
        @instance ||= self.new
        @instance.controller = controller
        @instance.after_condition?
      end

      def method_missing(m, *args)
        if controller.respond_to?(m)
          controller.send(m, *args)
        else
          super
        end
      end
    end
  end
end
