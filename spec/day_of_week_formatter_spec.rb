require "spec_helper"

RSpec.describe DayOfWeekFormatter, ".initialize" do
  it "accepts a string as an input argument" do
    input_argument = "*/6"
    formatter = DayOfWeekFormatter.new(input_argument: input_argument)

    expect(formatter.input_argument).to eq input_argument
  end

  it "accepts an english string as an input and converts" do
    input_argument = "sun"
    formatter = DayOfWeekFormatter.new(input_argument: input_argument)

    expect(formatter.input_argument).to eq "0"
  end
end

RSpec.describe DayOfWeekFormatter, "#format" do
  it "returns a formatted day of week string for */6 input" do
    input_argument = "*/3"
    formatter = DayOfWeekFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq "day of week   0 3 6"
  end
end

RSpec.describe DayOfWeekFormatter, "#format" do
  it "returns a formatted day of week string for * input" do
    input_argument = "*"
    formatter = DayOfWeekFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of week   0 1 2 3 4 5 6"
    )
  end
end

RSpec.describe DayOfWeekFormatter, "#format" do
  it "returns a formatted day of week string for comma separated input" do
    input_argument = "1,3,6"
    formatter = DayOfWeekFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of week   1 3 6"
    )
  end
end

RSpec.describe DayOfWeekFormatter, "#format" do
  it "returns a formatted day of week string for range input" do
    input_argument = "4-5"
    formatter = DayOfWeekFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of week   4 5"
    )
  end
end

RSpec.describe DayOfWeekFormatter, "#format" do
  it "returns a formatted day of week string for explicit input" do
    input_argument = "5"
    formatter = DayOfWeekFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "day of week   5"
    )
  end
end
