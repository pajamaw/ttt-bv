Dir.glob(File.join('../lib', '**', '*.rb')).each {|f| require f}
require_relative '../lib/cli_session.rb'
#for some reason this file wont' load
