require 'bundler'
Bundler.require
require 'telegram/bot'
require 'rufus-scheduler'
require_relative 'app/course_bot'
require_relative 'app/subscribe'
require_relative 'app/subscribe_schedule'
require_relative 'lib/figaro/adapter'
require 'rack'
Figaro.load

app = Proc.new do |env|
	    ['200', {'Content-Type' => 'text/html'}, ['A barebones rack app.']]
end

# Thread.new do
#   require_relative 'app'
# end

Rack::Handler::WEBrick.run app, daemonize: true
