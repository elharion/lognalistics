# frozen_string_literal: true

require 'json'

module Lognalistics
  module Presenters
    module Json
      class << self
        def call
          printer = Printer.new
          yield(printer)
          persist_results(printer.results)
        end

        private

        def persist_results(results)
          timestamp = Time.now.strftime('%Y%m%d%H%M%S')
          filepath  = File.join(ROOT_PATH, '/public/', "#{timestamp}_report.json")

          File.open(filepath, 'w+') do |file|
            file.write({ metrics: results }.to_json)
          end

          puts SimpleLocale.t('logs.report_available', path: filepath)
          puts SimpleLocale.t('logs.display_report', path: filepath)
          filepath
        end
      end

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
