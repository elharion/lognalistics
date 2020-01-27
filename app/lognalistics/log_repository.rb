module Lognalistics
  class LogRepository
    def initialize(store: RuntimeMemoryStore)
      @store = store
    end

    def save(path:, ip:)
      entry = { path: path, ip: ip }
      store.push(entry) && entry
    end

    private

    attr_reader :store
  end
end
