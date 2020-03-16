# frozen_string_literal: true

module Lognalistics
  module Decorators
    class UniqueView < SimpleDelegator
      def print
        SimpleLocale.t('unique_views', path: self[0], num: self[1][:unique_views].count)
      end
    end
  end
end
