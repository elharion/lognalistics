# frozen_string_literal: true

require 'bundler'
Bundler.require(:default)

APP_VERSION = '1.0.1'

# Load paths
ROOT_PATH = File.dirname(__dir__)
$LOAD_PATH.push ROOT_PATH

require 'pry'

# Simple data cache in memory
# rubocop:disable Style/MutableConstant
RuntimeMemoryStore = {}
# rubocop:enable Style/MutableConstant

# Run project dependencies
require 'config/initializers'
