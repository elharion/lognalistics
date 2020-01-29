# frozen_string_literal: true

module Lognalistics
  class MetricsCalculator
    def call(data, type)
      case type
      when :total_views
        calculate_views(data, type)
      when :unique_views
        calculate_views(data.uniq, type)
      else
        wrong_argument_exception
      end
    end

    private

    def wrong_argument_exception
      raise ArgumentError, "Wrong type provided, available: 'total_views, 'unique_views'"
    end

    # rubocop:disable Style/MultilineBlockChain
    def calculate_views(data, type)
      data.each_with_object({}) do |entry, result|
        result[entry[:path]] ||= Hash.new(0)
        result[entry[:path]][type] += 1
      end.sort_by do |_path, metric|
        -metric[type]
      end.to_h
    end
    # rubocop:enable Style/MultilineBlockChain
  end
end
