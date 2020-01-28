# frozen_string_literal: true

module Lognalistics
  module Presenters
    module Json
      def self.call(data)
        result = []
        data.each do |path, stats|
          stats.each do |type, val|
            result.push("#{path} - #{SimpleLocale[type].call(num: val)}")
          end
        end

        binding.pry
        { result: result }.to_json
      end
    end
  end
end
