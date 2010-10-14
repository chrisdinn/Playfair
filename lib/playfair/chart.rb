module Playfair
  class Chart
    attr_accessor :title

    def data(&block)
      if block_given?
        instance_eval &block
      else
        @data.dup
      end
    end
    
  end
end