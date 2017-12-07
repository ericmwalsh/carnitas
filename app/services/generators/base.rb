module Generators
  class Base
    class << self

      def run
        objects.each {|object| cache(object)}
      end

      private

      def cache(object)
        raise ::NotImplementedError, 'implement this in your subclass'
      end

      def objects
        raise ::NotImplementedError, 'implement this in your subclass'
      end

    end
  end
end
