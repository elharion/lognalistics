module Lognalistics
  class Processor
    def initialize(parser: nil, log_repo: nil, metric_calc: nil)
      @parser = parser || Parser
      @log_repo = log_repo || LogRepository.new
      @metric_calc = metric_calc || MetricsCalculator.new
    end

    def generate_statistics(file_path)
      parse_and_persist_logs(file_path)
      # stats = calculate_views(type)
      # present(stats, format: formatter)
      :success
    end

    private

    def calculate_views(type)
      []
    end

    def parse_and_persist_logs(file_path)
      parser.new(file_path).each_line do |entry|
        log_repo.save(path: entry[:path], ip: entry[:ip])
      end
    end

    attr_reader :parser, :log_repo
  end
end
