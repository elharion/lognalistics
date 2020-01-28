# frozen_string_literal: true

module Lognalistics
  class Processor
    def initialize(parser: nil, log_repo: nil, metric_calc: nil, presenter: nil)
      @parser = parser || Parser
      @log_repo = log_repo || LogRepository.new
      @metric_calc = metric_calc || MetricsCalculator.new
      @presenter = presenter || Presenter.new
    end

    def generate_statistics(file_path, type, output_format)
      parse_and_persist_logs(file_path)
      stats = calculate_views(type)
      show_statistics(stats, output_format)
    end

    private

    def show_statistics(stats, output_format)
      presenter.render(stats, output_format)
    end

    def calculate_views(type)
      metric_calc.call(log_repo.all, type)
    end

    def parse_and_persist_logs(file_path)
      parser.new(file_path).each_line do |entry|
        log_repo.save(path: entry[:path], ip: entry[:ip])
      end
    end

    attr_reader :parser, :log_repo, :metric_calc, :presenter
  end
end
