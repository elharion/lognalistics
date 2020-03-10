# frozen_string_literal: true

module Lognalistics
  class Processor
    def initialize(parser: nil, log_repo: nil, presenters: nil)
      @parser = parser || Parser
      @log_repo = log_repo || LogRepository.new
      @presenters = presenters || Presenter.new
    end

    def call(file_path, types, output_format)
      parse_and_persist_logs(file_path)

      types.each_with_object([]) do |type, results|
        presenter = select_presenter(output_format)
        decorator = map_to_decorator(type)
        query     = map_to_query(type)

        results << print_metrics(presenter, decorator, query)
      end
    end

    private

    def map_to_decorator(type)
      {
        total_views:  Lognalistics::Decorators::TotalView,
        unique_views: Lognalistics::Decorators::UniqueView
      }.fetch(type) do
        raise ArgumentError, "Type #{type} is not supported. Available 'total_views', 'unique_views'"
      end
    end

    def map_to_query(type)
      {
        total_views: :all_by_total_views,
        unique_views: :all_by_unique_views
      }.fetch(type) do
        raise ArgumentError, "Type #{type} is not supported. Available 'total_views', 'unique_views'"
      end
    end

    def print_metrics(presenter, decorator, query)
      presenter.call do |printer|
        log_repo.public_send(query).each do |entry_metrics|
          printer << decorator.print(entry_metrics)
        end
      end
    end

    def select_presenter(output_format)
      presenters.call(output_format)
    end

    def parse_and_persist_logs(file_path)
      parser.new(file_path).each_line do |entry|
        log_repo.save(path: entry[:path], ip: entry[:ip])
      end
    end

    attr_reader :parser, :log_repo, :presenters
  end
end
