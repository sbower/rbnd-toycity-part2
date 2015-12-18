#!/usr/bin/env ruby
require 'optparse'
require File.expand_path(File.dirname(__FILE__) + '/../lib/app')

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: run_report.rb [options]"

  opts.on('-s', '--standard-out', 'Print the report to standard out instead of lib/report.txt') { |v| options[:stdout] = v }
  opts.on("-h", "--help", "Prints this help") do
    puts opts
    exit
  end

end.parse!

print_report({file: !options[:stdout]})
