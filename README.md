# RooCron

RooCron is a cron string parser built in Ruby.

It takes a string of the cron instructions followed by the command you wish to
run and feeds back a table containing details of when the cron task will execute
the command, in a more human readable format.

## Architecture

The CronParser and Formatter hold most of the knowledge.

The CronParser takes a user input, the ExpressionValidator checks that it's
valid as far as structure is concerned, the Normalizer then converts any non
integer months/days into their integer equivalents, and the Expression is
responsible for knowing which parts of of the user input correspond to what.

The CronParser knows how to put all these elements together and pass them to the
Formatter which generates individual rows for the outputted table.

The Formatter takes a cron sub expression, a permitted range, a timescale
string, and a DelimiterDescriber - an object responsible for knowing about the
delimiters used in cron expressions \*, /, - and ,

The Formatter passes the sub expression to the SubExpressionValidator along with
the delimiter and acceptable range to validate that the sub expression is valid
for the component it relates to. A year has months 1-12, so if you ask for month
13 it will fail here.

The Formatter then generates a valid output string for each sub expression and
returns it to the CronParser for output

## Usage

To run, locate yourself in the application's home directory and run:

    ruby bin/cron_parser.rb "*/15 0 1,15 * 1-5 /usr/bin/find"

The output should be:

    minute        0 15 30 45
    hour          0
    day of month  1 15
    month         1 2 3 4 5 6 7 8 9 10 11 12
    day of week   1 2 3 4 5
    command       /usr/bin/find

If you enter an invalid argument you will receive a RuntimeError with a message
explaining what's wrong. For example if you ask for the 12th day of the week

    ruby bin/cron_parser.rb "* * * * 12 /usr/bin/find"

The output is

    Request invalid, day of week must be between 0..6 (RuntimeError)

## Tests

Tests are in RSpec so:

    gem install rspec

and once again from the root directory

    rspec

simple cov can tell you how much of the application is covered by the tests

    gem install simplecov
    rspec
    open coverage/index.html

## Todos

I would like more concrete examples confirmed by the tests. But given the time
constraints I didn't have time to put these together.
