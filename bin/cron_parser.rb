#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'cron_parser'

input_argument = ARGV[0]
parser = CronParser.new(input_argument: input_argument)
puts parser.parse
