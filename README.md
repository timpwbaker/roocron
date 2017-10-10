RooCron is a cron string parser built in Ruby.

It takes a string of the cron instructions followed by the command you wish to
run and feeds back a table containing details of when the cron task will execute
the command, in a more human readable format.

To run, locate yourself in the application's home directory and run:

    ruby bin cron_parser.rb "*/15 0 1,15 * 1-5 /usr/bin/find"

The output should be:

    minute        0 15 30 45
    hour          0
    day of month  1 15
    month         1 2 3 4 5 6 7 8 9 10 11 12
    day of week   1 2 3 4 5
    command       /usr/bin/find

Tests are in RSpec so:

    gem install rspec

and once again from the root directory

    rspec
