# frozen_string_literal: true

module Lognalistics
  module Presenters
    module Json
      def self.call
        printer = Printer.new
        yield(printer)

        { result: printer.results }.to_json
      end

      private

      class Printer
        def initialize
          @results = []
        end

        def <<(path_metrics)
          results.push path_metrics
        end

        attr_reader :results
      end
    end
  end
end
