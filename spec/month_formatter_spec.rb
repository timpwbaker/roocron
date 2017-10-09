require "spec_helper"

RSpec.describe MonthFormatter, ".initialize" do
  it "accepts a string as an input argument" do
    input_argument = "*/6"
    formatter = MonthFormatter.new(input_argument: input_argument)

    expect(formatter.input_argument).to eq input_argument
  end

  it "accepts an english string as an input and converts" do
    input_argument = "jan"
    formatter = MonthFormatter.new(input_argument: input_argument)

    expect(formatter.input_argument).to eq "1"
  end
end

RSpec.describe MonthFormatter, "#format" do
  it "returns a formatted month string for */6 input" do
    input_argument = "*/6"
    formatter = MonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq "month         6 12"
  end
end

RSpec.describe MonthFormatter, "#format" do
  it "returns a formatted month string for * input" do
    input_argument = "*"
    formatter = MonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "month         1 2 3 4 5 6 7 8 9 10 11 12"
    )
  end
end

RSpec.describe MonthFormatter, "#format" do
  it "returns a formatted month string for comma separated input" do
    input_argument = "1,3,12"
    formatter = MonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "month         1 3 12"
    )
  end
end

RSpec.describe MonthFormatter, "#format" do
  it "returns a formatted month string for range input" do
    input_argument = "4-10"
    formatter = MonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "month         4 5 6 7 8 9 10"
    )
  end
end

RSpec.describe MonthFormatter, "#format" do
  it "returns a formatted month string for explicit input" do
    input_argument = "32"
    formatter = MonthFormatter.new(input_argument: input_argument)

    expect(formatter.format).to eq(
      "month         32"
    )
  end
end
