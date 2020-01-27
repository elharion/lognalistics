module Lognalistics
  class Processor
    def initialize(parser: nil, log_repo: nil)
      @parser = parser || Lognalistics::Parser
      @log_repo = log_repo || Lognalistics::LogRepository.new
    end

    def generate_statistics(file_path)
      parse_and_persist_logs(file_path)
      :success
    end

    private

    def parse_and_persist_logs(file_path)
      parser.new(file_path).each_line do |entry|
        log_repo.save(path: entry[:path], ip: entry[:ip])
      end
    end

    attr_reader :parser, :log_repo
  end
end
