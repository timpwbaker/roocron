#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cron_parser'

user_input = ARGV[0]
parser = CronParser.new(user_input: user_input)
puts parser.parse
