# frozen_string_literal: true

# Load paths
ROOT_PATH = File.dirname(__dir__)
$LOAD_PATH.push ROOT_PATH

# Run external dependencies
require 'pry'

# Simple data cache in memory
# rubocop:disable Style/MutableConstant
RuntimeMemoryStore = {}
# rubocop:enable Style/MutableConstant

# locales simulation
module SimpleLocale
  class << self
    DATA = {
      en: {
        total_views:  ->(num:, path:) { "#{path} - visits: #{num}" },
        unique_views: ->(num:, path:) { "#{path} - unique views: #{num}" }
      }
    }.freeze

    def t(path, args)
      path_args = path.split('.').map(&:to_sym)
      scoped_by_language.dig(*path_args)&.call(**args)
    end

    private

    def scoped_by_language
      DATA[ENV['APP_LANGUAGE'].to_sym] || DATA[:en]
    end
  end
end

# Run project dependencies
require 'config/initializers'
