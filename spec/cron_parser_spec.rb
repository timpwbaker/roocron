require "spec_helper"

RSpec.describe CronParser, ".initialize" do
  it "accepts a string as an input argument" do
    input_argument = "*/15 0 1,15 * 1-5 /usr/bin/find"
    parser = CronParser.new(input_argument: input_argument)

    expect(parser.input_argument).to eq input_argument
  end
end

RSpec.describe CronParser, "#parse" do
  it "returns the correct response" do
    input_argument = "*/15 0 1,15 * 1-5 /usr/bin/find"
    parser = CronParser.new(input_argument: input_argument)

    expect(parser.parse).to eq known_result
  end
end

def known_result
  [
    "minute        0 15 30 45",
    "hour          0",
    "day of month  1 15",
    "month         1 2 3 4 5 6 7 8 9 10 11 12",
    "day of week   1 2 3 4 5",
    "command       /usr/bin/find"
  ].join("\n") + "\n"
end
