require "spec_helper"

RSpec.describe Expression, ".initialize" do
  it "takes a valid user input as an argument" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.user_input).to eq "*/15 0 1,15 * 1-5 /usr/bin/find"
  end
end

RSpec.describe Expression, "#english_output" do
  it "returns the english output for a user input" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.express).to eq known_result
  end

  it "raises an error if there are not enough elements in the expression" do
    user_input = "0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect { expression.express }.to raise_error(
      RuntimeError, "Invalid input expression, the input should be 5 cron"\
      " elements followed by a command. For details please checkout the README")
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
