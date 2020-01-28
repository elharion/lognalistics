# frozen_string_literal: true

module Lognalistics
  module Presenters
    module Stdout
      def self.call(data)
        data.each do |path, stats|
          stats.each do |stat, val|
            $stdout.puts("#{path} - #{SimpleLocale[stat].call(num: val)}")
          end
        end
      end
    end
  end
end
