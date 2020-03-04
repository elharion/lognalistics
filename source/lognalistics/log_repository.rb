# frozen_string_literal: true

module Lognalistics
  class LogRepository
    def initialize(store: nil)
      @store = store || RuntimeMemoryStore
    end

    def save(path:, ip:)
      entry = { path: path, ip: ip }
      store.push(entry) && entry
    end

    def all
      store
    end

    private

    attr_reader :store
  end
end
