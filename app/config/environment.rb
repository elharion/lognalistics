# Load paths
ROOT_PATH = File.dirname(__dir__)
$LOAD_PATH.push ROOT_PATH

# Run external dependencies
require 'pry'

# Simple data cache in memory
MemoryStore = []

# Run project dependencies
require 'config/initializers'
