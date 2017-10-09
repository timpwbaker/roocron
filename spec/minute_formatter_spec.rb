require "spec_helper"

RSpec.describe MinuteFormatter, ".initialize" do
  it "accepts a string as an input argument" do
    input_argument = "*/15"
    formatter = MinuteFormatter.new(input_argument: input_argument)

    expect(formatter.input_argument).to eq input_argument
  end
end

RSpec.describe MinuteFormatter, "#format" do
  it "returns a formatted minute string for */15 input" do
    input_argument = "*/15"
    formatter = MinuteFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq "minute        0 15 30 45"
  end
end

RSpec.describe MinuteFormatter, "#format" do
  it "returns a formatted minute string for * input" do
    input_argument = "*"
    formatter = MinuteFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "minute        0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 57 58 59"
    )
  end
end

RSpec.describe MinuteFormatter, "#format" do
  it "returns a formatted minute string for comma separated input" do
    input_argument = "10,27,38"
    formatter = MinuteFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "minute        10 27 38"
    )
  end
end

RSpec.describe MinuteFormatter, "#format" do
  it "returns a formatted minute string for range input" do
    input_argument = "25-32"
    formatter = MinuteFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "minute        25 26 27 28 29 30 31 32"
    )
  end
end

RSpec.describe MinuteFormatter, "#format" do
  it "returns a formatted minute string for explicit input" do
    input_argument = "32"
    formatter = MinuteFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "minute        32"
    )
  end
end
