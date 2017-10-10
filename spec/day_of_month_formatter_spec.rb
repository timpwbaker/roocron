require "spec_helper"

RSpec.describe DayOfMonthFormatter, ".initialize" do
  it "accepts a string as an input argument" do
    input_argument = "*/10"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect(formatter.input_argument).to eq input_argument
  end
end

RSpec.describe DayOfMonthFormatter, "#format" do
  it "returns a formatted day of month string for */15 input" do
    input_argument = "*/10"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq "day of month  10 20 30"
  end

  it "returns error if divisor is outside possible range" do
    input_argument = "*/40"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, day of month must be between 1..31")
  end
end

RSpec.describe DayOfMonthFormatter, "#format" do
  it "returns a formatted day of month string for * input" do
    input_argument = "*"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of month  1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31"
    )
  end
end

RSpec.describe DayOfMonthFormatter, "#format" do
  it "returns a formatted day of month string for comma separated input" do
    input_argument = "1,3,16"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of month  1 3 16"
    )
  end

  it "returns error if any of provided list is outside possible range" do
    input_argument = "1,12,40"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, day of month must be between 1..31")
  end
end

RSpec.describe DayOfMonthFormatter, "#format" do
  it "returns a formatted day of month string for range input" do
    input_argument = "25-31"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of month  25 26 27 28 29 30 31"
    )
  end

  it "returns error if any of provided range is outside possible range" do
    input_argument = "12-40"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, day of month must be between 1..31")
  end
end

RSpec.describe DayOfMonthFormatter, "#format" do
  it "returns a formatted day of month string for explicit input" do
    input_argument = "31"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of month  31"
    )
  end

  it "returns error if the provided input is outside possible range" do
    input_argument = "40"
    formatter = DayOfMonthFormatter.new(input_argument: input_argument)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, day of month must be between 1..31")
  end
end
