# frozen_string_literal: true

module Lognalistics
  class LogRepository
    def initialize(store: nil)
      @store = store || RuntimeMemoryStore
    end

    def save(path:, ip:)
      store[path] ||= init_entry

      store[path].tap do |entry|
        entry[:total_views] += 1
        entry[:unique_views] << ip
      end
    end

    def all_by_unique_views
      store
        .sort_by { |path, stats| [-stats[:unique_views].count, path] }
        .map { |metric| Lognalistics::Decorators::UniqueView.new(metric) }
    end

    def all_by_total_views
      store
        .sort_by { |path, stats| [-stats[:total_views], path] }
        .map { |metric| Lognalistics::Decorators::TotalView.new(metric) }
    end

    private

    def init_entry
      { total_views: 0, unique_views: Set.new }
    end

    attr_reader :store
  end
end
