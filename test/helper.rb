$: << File.join(File.dirname(__FILE__), "..", "lib")
require 'test/unit'
require 'rpm'

def fixture(name)
  File.expand_path(File.join(File.dirname(__FILE__), 'data', name))
end