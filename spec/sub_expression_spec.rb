require "spec_helper"

RSpec.describe SubExpression, ".initialize" do
  it "takes a valid sub expression as an argument" do
    sub_expression_string = "*/15"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression_string)
    permitted_range = (0..59)
    timescale_string = "minute"
    sub_expression = SubExpression.new(
      sub_expression_string: sub_expression_string,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      delimiter_describer: delimiter_describer)

    expect(sub_expression.sub_expression_string).to eq "*/15"
    expect(sub_expression.timescale_string).to eq "minute"
    expect(sub_expression.permitted_range).to eq (0..59)
    expect(sub_expression.delimiter_describer).to eq delimiter_describer
  end
end

RSpec.describe SubExpression, "#english_string" do
  it "returns a formatted string for a */15 style input" do
    sub_expression_string = "*/15"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression_string)
    permitted_range = (0..59)
    timescale_string = "minute"
    sub_expression = SubExpression.new(
      sub_expression_string: sub_expression_string,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(sub_expression.english_string).to eq "minute        0 15 30 45"
  end
end

RSpec.describe SubExpression, "#english_string" do
  it "returns a formatted string for a * (wildcard) input" do
    sub_expression_string = "*"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression_string)
    permitted_range = (0..23)
    timescale_string = "hour"
    sub_expression = SubExpression.new(
      sub_expression_string: sub_expression_string,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      delimiter_describer: delimiter_describer)

    expect(sub_expression.english_string).to eq(
      "hour          0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23"
    )
  end
end

RSpec.describe SubExpression, "#english_string" do
  it "returns a formatted string for a comma separated list style input" do
    sub_expression_string = "10,27,31"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression_string)
    permitted_range = (1..31)
    timescale_string = "day of month"
    sub_expression = SubExpression.new(
      sub_expression_string: sub_expression_string,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(sub_expression.english_string).to eq(
      "day of month  10 27 31"
    )
  end
end

RSpec.describe SubExpression, "#english_string" do
  it "returns a formatted string for hyphenated range style input" do
    sub_expression_string = "25-32"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression_string)
    permitted_range = (0..59)
    timescale_string = "minute"
    sub_expression = SubExpression.new(
      sub_expression_string: sub_expression_string,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(sub_expression.english_string).to eq(
      "minute        25 26 27 28 29 30 31 32"
    )
  end
end

RSpec.describe SubExpression, "#english_string" do
  it "returns a formatted string for an explicit input" do
    sub_expression_string = "12"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression_string)
    permitted_range = (0..59)
    timescale_string = "minute"
    sub_expression = SubExpression.new(
      sub_expression_string: sub_expression_string,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect(sub_expression.english_string).to eq(
      "minute        12"
    )
  end
end
