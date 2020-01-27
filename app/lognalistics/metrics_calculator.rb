module Lognalistics
  class MetricsCalculator
    def call(data, type)
      case type
      when :total_views
        return calculate_views(data, type)
      when :unique_views
        return calculate_views(data.uniq, type)
      else
        wrong_argument_exception
      end
    end

    private

    def wrong_argument_exception
      raise ArgumentError, "Wrong type provided, available: 'total_views, 'unique_views'"
    end

    def calculate_views(data, type)
      data.each_with_object({}) do |entry, result|
        path_counter = result.dig(:path, type) || 0
        result[entry[:path]] ||= Hash.new(0)
        result[entry[:path]][type] += 1
      end
    end
  end
end
