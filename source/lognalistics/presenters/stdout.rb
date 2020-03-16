# frozen_string_literal: true

require 'rainbow'

module Lognalistics
  module Presenters
    module Stdout
      def self.call
        printer = Printer.new
        yield(printer)
        nil
      end

      private

      class Printer
        def <<(path_metrics)
          $stdout.puts(path_metrics)
        end
      end
    end
  end
end
