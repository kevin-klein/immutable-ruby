module Hamster

  module Immutable

    def self.included(klass)
      klass.extend(ClassMethods)
      klass.instance_eval do
        include InstanceMethods
      end
    end

    module ClassMethods

      def new(*args)
        super.freeze
      end

    end

    module InstanceMethods

      def immutable?
        frozen?
      end

      alias_method :__hamster_dup__, :dup
      private :__hamster_dup__

      def dup
        self
      end

      def clone
        self
      end

      protected

      def transform_unless(condition, &block)
        condition ? self : transform(&block)
      end

      def transform(&block)
        __hamster_dup__.tap { |copy| copy.instance_eval(&block) }.freeze
      end

    end

  end

end