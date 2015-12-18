#!/usr/bin/env ruby
require File.expand_path(File.dirname(__FILE__) + '/../lib/app')

$stdout.reopen(File.join(File.dirname(__FILE__), '../lib/report.txt'), 'w')

print_report
