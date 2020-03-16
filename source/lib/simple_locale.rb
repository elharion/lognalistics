# frozen_string_literal: true

require 'rainbow'

module SimpleLocale
  class << self
    # This is just simulation of locales. Normally I'd use i18n gem or read from YML.
    DATA = {
      en: {
        cli: {
          metrics: {
            command_desc: ->(*) { 'For provided log file generates webpage metrics for total visits or unique views.' },
            filename_desc: ->(*) { 'Name of a log file' },
            output_desc: ->(*) { 'Output format for metrics delivery' },
            type_desc: ->(*) { 'Type of requested metric' }
          },
          version: {
            command_desc: ->(*) { 'Prints program version' }
          }
        },
        errors: {
          file_doesnt_exist: ->(path:) { "File #{path} doesn't exist. Please provide proper file path." },
          output_not_supported: ->(output:) { "Output format #{output} is not supported. Available: 'stdout', 'json'." },
          type_not_supported: ->(type:) { "Type #{type} is not supported. Available 'total_views', 'unique_views'." }
        },
        logs: {
          display_report: ->(path:) { "Run '#{Rainbow("cat #{path} | jq .").green}' or display via preferred program" },
          metrics: {
            for: ->(path:) { Rainbow('Metrics for: ').white + Rainbow(path).yellow },
            output: ->(output:) { Rainbow('Metrics output: ').white + Rainbow(output).yellow },
            title: ->(*) { Rainbow("\nMetrics:").cyan },
            type: ->(type:) { Rainbow('Metrics type: ').white + Rainbow(type).yellow }
          },
          report_available: ->(path:) { "Metrics report available in #{path}" },
          separator: ->(*) { Rainbow('-------------').white }
        },
        total_views:  ->(num:, path:) { "#{path} - visits: #{num}" },
        unique_views: ->(num:, path:) { "#{path} - unique views: #{num}" }
      }
    }.freeze

    def t(path, args = {})
      path_args = path.split('.').map(&:to_sym)
      scoped_by_language.dig(*path_args)&.call(**args)
    end

    private

    def scoped_by_language
      DATA[ENV['APP_LANGUAGE'].to_sym] || DATA[:en]
    end
  end
end
