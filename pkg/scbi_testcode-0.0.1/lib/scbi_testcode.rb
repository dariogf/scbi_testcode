$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'scbi_testcode/testcode'

module ScbiTestcode
  VERSION = '0.0.1'
end
