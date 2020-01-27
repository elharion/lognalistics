module Lognalistics
  class Processor
    def initialize(parser: nil, log_repo: nil)
      @parser = parser || Lognalistics::Parser
      @log_repo = log_repo || Lognalistics::LogRepository.new
    end

    def generate_statistics
      :success
    end
  end
end
