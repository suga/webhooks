#!/usr/bin/ruby
Dir[File.expand_path "src/*.rb"].each{|f| require_relative(f)}

begin
  filename = ARGV.first
  log_file = File.read(filename, encoding: 'ISO-8859-1:UTF-8')
rescue
  puts 'One error ocurred when reader the logFile.'
  puts 'Use: ruby bootstrap.rb log.txt'
  exit
end

webhook = Webhook.new(log_file: log_file)
helper = LogHelper.new(webhook: webhook)
puts helper.top_requests_whit(limit:3)
puts helper.status_table