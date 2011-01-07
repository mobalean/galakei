class ActionController::TestCase
  class << self
    {:pc => "mozilla", :galakei => "DoCoMo/2.0 SH06A3(c500;TB;W24H14)"}.each do |method, user_agent|
      class_eval(<<-EOD)
        def with_#{method}(&block)
          context("with #{method} browser") do
            setup { @request.user_agent = '#{user_agent}' }
            merge_block(&block)
          end
        end
      EOD
    end
    def with_pc_and_galakei(&block)
      with_pc(&block)
      with_galakei(&block)
    end
  end
end

