require "spec_helper"

RSpec.describe Formatter, ".initialize" do
  it "accepts a timescale string, a permitted range, a user input and english hash" do
    sub_expression = "*/15"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(formatter.sub_expression).to eq sub_expression
    expect(formatter.permitted_range).to eq permitted_range
    expect(formatter.timescale_string).to eq timescale_string
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for a */15 style input" do
    sub_expression = "*/15"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(formatter.format).to eq "minute        0 15 30 45"
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for a * (wildcard) input" do
    sub_expression = "*"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    permitted_range = (0..23)
    timescale_string = "hour"
    formatter = Formatter.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      delimiter_describer: delimiter_describer)

    expect(formatter.format).to eq(
      "hour          0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23"
    )
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for a comma separated list style input" do
    sub_expression = "10,27,31"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    permitted_range = (1..31)
    timescale_string = "day of month"
    formatter = Formatter.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(formatter.format).to eq(
      "day of month  10 27 31"
    )
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for hyphenated range style input" do
    sub_expression = "25-32"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(formatter.format).to eq(
      "minute        25 26 27 28 29 30 31 32"
    )
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for an explicit input" do
    sub_expression = "12"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(formatter.format).to eq(
      "minute        12"
    )
  end
end
