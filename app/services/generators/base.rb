module Generators
  class Base
    class << self

      def run
        raise ::NotImplementedError, 'implement this in your subclass'
      end

      private

    end
  end
end
