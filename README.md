# RooCron

RooCron is a cron string parser built in Ruby.

It takes a string of the cron instructions followed by the command you wish to
run and feeds back a table containing details of when the cron task will execute
the command, in a more human readable format.

## Architecture

CronParser knows about and controls the world. It takes the user input and knows
how to instantiate all the objects required for returning the output to the
user.

UserInputValidator checks the user input has the correct number of compontents,
Normalizer objects normalize the user input (for example from mon to 1),
SubExpression objects know how to do the formatting of each line of the eventual
output and DelimiterDesriber objects hold information about how each
SubExpression is delimited, as "1-5" needs to be treated differently to 1,5.

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

SimpleCov is required to run the tests, it will tell you how much of the code is
covered by tests

    gem install simplecov

Tests are in RSpec so:

    gem install rspec
    rspec

To view test coverage

    open coverage/index.html

## Todos

I would like more concrete examples confirmed by the tests. But given the time
constraints I didn't have time to put these together.

I am aware of some edge cases - not covered due to time:

  * If users provide day/month strings combined with a \*/ format input (e.g.
    \*/tue) it will convert this to \*/2 and evalutate. This should error
  * If users input arguments containing multi delimited sub expressions (e.g.
    1-3,8 it returns a RuntimeError, it should return 1 2 3 8

There is a method - DelimiterDescriber#permitted_methods - that requires the
array to be in a specific order to correctly identify the delimiter of a string.
This is too precarious for my liking but the tests will fail if it is
incorrectly ordered, so it is safe(ish) for now.

There is some interesting behaviour with OpenStruct. If I don't require it
within CronParser the tests run green but running the application from the
command line returns an error `uninitialized constant CronParser::OpenStruct`. I
first assumed this was coming from RSpec, but some investigating and a
StackOverflow question revealed it was actually the JSON library used by Simple
Cov which was causing the issue.
