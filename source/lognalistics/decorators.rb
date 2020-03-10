# frozen_string_literal: true

module Lognalistics
  module Decorators
    class TotalView
      def self.print(entry)
        SimpleLocale.t('total_views', path: entry[0], num: entry[1][:total_views])
      end
    end

    class UniqueView
      def self.print(entry)
        SimpleLocale.t('unique_views', path: entry[0], num: entry[1][:unique_views].count)
      end
    end
  end
end
