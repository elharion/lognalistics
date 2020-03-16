# frozen_string_literal: true

module Lognalistics
  module Decorators
    class TotalView < SimpleDelegator
      def print
        SimpleLocale.t('total_views', path: self[0], num: self[1][:total_views])
      end
    end
  end
end
