require "spec_helper"

RSpec.describe CronParser, ".initialize" do
  it "accepts a string as an input argument" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    parser = CronParser.new(user_input: user_input)

    expect(parser.user_input).to eq user_input
  end

  it "returns an error if the input has the wrong number of elements" do
    user_input = "* * * * /usr/bin/find"
    parser = CronParser.new(user_input: user_input)

    expect { parser.parse }.to raise_error(
      RuntimeError,
      "Invalid input expression, the input should be 5 cron elements followed "\
      "by a command. For details please checkout the README")
  end

  it "returns an error if no user input is given" do
    user_input = nil
    parser = CronParser.new(user_input: user_input)

    expect { parser.parse }.to raise_error(
      RuntimeError, "There has been a problem, have you provided an input?")
  end
end

RSpec.describe CronParser, "#parse" do
  it "errors from the sub expression validator bubble up successfully" do
    user_input = "60 0 1,15 * 1-5 /usr/bin/find"
    parser = CronParser.new(user_input: user_input)

    expect { parser.parse }.to raise_error(
      RuntimeError, "Request invalid, minute must be between 0..59")
  end

  it "returns the known response" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    parser = CronParser.new(user_input: user_input)

    expect(parser.parse).to eq known_result
  end

  it "returns the correct response for each of the examples" do
    example_arguments.each_with_index do |example_argument, index|
      user_input = example_argument
      parser = CronParser.new(user_input: user_input)

      expect(parser.parse).to eq example_results[index]
    end
  end

  it "doesn't raise errors for a load more known valid examples" do
    more_examples.each_with_index do |example_argument, index|
      user_input = example_argument
      parser = CronParser.new(user_input: user_input)

      expect { parser.parse }.not_to raise_error
    end
  end
end

def more_examples
  [
    "* * * * * bin/something", "* * * * * bin/something",
    "* * * * * bin/something", "*/15 * * * * bin/something",
    "*/15,25 * * * * bin/something", "30 3,6,9 * * * bin/something",
    "30 9 * * * bin/something", "30 9 * * * bin/something",
    "30 9 * * * bin/something", "0 9 * * * bin/something",
    "* * 12 * * bin/something", "* * * * 1,3 bin/something",
    "* * * * MON,WED bin/something", "0 0 1 1 * bin/something",
    "0 0 * * 1 bin/something", "0 0 * * 1 bin/something",
    "45 23 7 3 * bin/something", "0 0 1 jun * bin/something",
    "0 0 1 may,jul * bin/something", "0 0 1 MAY,JUL * bin/something",
    "40 5 * * * bin/something", "0 5 * * 1 bin/something",
    "10 8 15 * * bin/something", "50 6 * * 1 bin/something",
    "1 2 * apr mOn bin/something", "1 2 3 4 7 bin/something",
    "1 2 3 4 7 bin/something", "1-20/3 * * * * bin/something",
    "1,2,3 * * * * bin/something", "1-9,15-30 * * * * bin/something",
    "1-9/3,15-30/4 * * * * bin/something", "1 2 3 jan mon bin/something",
    "1 2 3 4 mON bin/something", "1 2 3 jan 5 bin/something",
    "*/3 * * * * bin/something", "0 5 * 2,3 * bin/something",
    "15-59/15 * * * * bin/something", "15-59/15 * * * * bin/something",
    "15-59/15 * * * * bin/something", "15-59/15 * * * * bin/something",
    "15-59/15 * * * * bin/something", "15-59/15 * * * * bin/something",
    "15-59/15 * * * * bin/something", "15-59/15 * * * * bin/something",
    "15-59/15 * * * * bin/something"
  ]
end

def example_arguments
  [
    "* * * * * /usr/bin/find",
    "45 0 1,15 jan sun /usr/bin/find",
    "*/15 0 1,15 * 1-5 /usr/bin/find"
  ]
end

def example_results
  [
    [
      "minute        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59",
      "hour          0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23",
      "day of month  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31",
      "month         1 2 3 4 5 6 7 8 9 10 11 12",
      "day of week   0 1 2 3 4 5 6",
      "command       /usr/bin/find"
    ].join("\n") + "\n",
    [
      "minute        45",
      "hour          0",
      "day of month  1 15",
      "month         1",
      "day of week   0",
      "command       /usr/bin/find"
    ].join("\n") + "\n",
    [
      "minute        0 15 30 45",
      "hour          0",
      "day of month  1 15",
      "month         1 2 3 4 5 6 7 8 9 10 11 12",
      "day of week   1 2 3 4 5",
      "command       /usr/bin/find"
    ].join("\n") + "\n"
  ]
end
