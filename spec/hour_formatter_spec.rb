require "spec_helper"

RSpec.describe HourFormatter, ".initialize" do
  it "accepts a string as an input argument" do
    input_argument = "*/2"
    formatter = HourFormatter.new(input_argument: input_argument)

    expect(formatter.input_argument).to eq input_argument
  end
end

RSpec.describe HourFormatter, "#format" do
  it "returns a formatted hour string for */6 input" do
    input_argument = "*/6"
    formatter = HourFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq "hour          0 6 12 18"
  end
end

RSpec.describe HourFormatter, "#format" do
  it "returns a formatted hour string for * input" do
    input_argument = "*"
    formatter = HourFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "hour          0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23"
    )
  end
end

RSpec.describe HourFormatter, "#format" do
  it "returns a formatted hour string for comma separated input" do
    input_argument = "1,3,16"
    formatter = HourFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "hour          1 3 16"
    )
  end
end

RSpec.describe HourFormatter, "#format" do
  it "returns a formatted hour string for range input" do
    input_argument = "25-32"
    formatter = HourFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "hour          25 26 27 28 29 30 31 32"
    )
  end
end

RSpec.describe HourFormatter, "#format" do
  it "returns a formatted hour string for explicit input" do
    input_argument = "32"
    formatter = HourFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "hour          32"
    )
  end
end
