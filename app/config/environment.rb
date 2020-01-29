# frozen_string_literal: true

# Load paths
ROOT_PATH = File.dirname(__dir__)
$LOAD_PATH.push ROOT_PATH

# Run external dependencies
require 'pry'

# Simple data cache in memory
RuntimeMemoryStore = []

# Run project dependencies
require 'config/initializers'

# locales simulation
SimpleLocale = {
  total_views: ->(num:) { "visits: #{num}" },
  unique_views: ->(num:) { "unique views: #{num}" }
}.freeze
