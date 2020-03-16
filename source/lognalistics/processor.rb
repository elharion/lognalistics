# frozen_string_literal: true

require 'rainbow'

module Lognalistics
  class Processor
    def initialize(parser: nil, log_repo: nil, presenter: nil)
      @parser    = parser    || Parser
      @log_repo  = log_repo  || LogRepository.new
      @presenter = presenter || Presenter.new
    end

    def call(log_filename, type, output)
      parse_and_persist_logs(log_filename)

      presenter = select_presenter(output)
      query     = map_to_query(type)
      metrics   = fetch_metrics(query)

      log_processing_context(log_filename, type, output)

      print_metrics(
        metrics: metrics,
        presenter: presenter
      )
    end

    private

    def parse_and_persist_logs(log_filename)
      parser.new(log_filename).each_line do |entry|
        log_repo.save(path: entry[:path], ip: entry[:ip])
      end
    end

    def select_presenter(output)
      presenter.call(output)
    end

    def map_to_query(type)
      {
        total_views: :all_by_total_views,
        unique_views: :all_by_unique_views
      }.fetch(type.to_sym) do
        raise ArgumentError, SimpleLocale.t('errors.type_not_supported', type: type)
      end
    end

    def fetch_metrics(query)
      log_repo.public_send(query)
    end

    def log_processing_context(log_filename, type, output)
      puts SimpleLocale.t('logs.separator')
      puts SimpleLocale.t('logs.metrics.for', path: log_filename)
      puts SimpleLocale.t('logs.metrics.type', type: type)
      puts SimpleLocale.t('logs.metrics.output', output: output)
      puts SimpleLocale.t('logs.metrics.title')
    end

    def print_metrics(metrics:, presenter:)
      presenter.call do |printer|
        metrics.each { |metric| printer << metric.print }
      end
    end

    attr_reader :parser, :log_repo, :presenter
  end
end
