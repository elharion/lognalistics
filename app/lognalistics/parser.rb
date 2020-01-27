module Lognalistics
  class Parser
    def initialize(file_path)
      @file_path = file_path
    end

    def each_line(&block)
      IO.foreach(file_path) do |line|
        path, ip = line.split(%r{\s})
        block.call({ path: path, ip: ip })
      end
    end

    private

    attr_reader :file_path
  end
end
