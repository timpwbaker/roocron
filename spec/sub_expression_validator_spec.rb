require "spec_helper"

RSpec.describe SubExpressionValidator, ".initialize" do
  it "takes a sub expression and a range as an argument" do
    sub_expression = "1-4"
    permitted_range = (1..90)
    timescale_string = "minute"
    delimiter_describer = DelimiterDescriber.new(
      sub_expression: sub_expression)
    validator = SubExpressionValidator.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      delimiter_describer: delimiter_describer)

    expect(validator.sub_expression).to eq "1-4"
    expect(validator.permitted_range).to eq (1..90)
  end
end

RSpec.describe SubExpressionValidator, ".valid?" do
  it "returns error if divisor is outside possible range" do
    sub_expression = "*/15"
    permitted_range = (0..6)
    timescale_string = "day of week"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    validator = SubExpressionValidator.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect { validator.valid? }.to raise_error(
      RuntimeError,
      "Request invalid, day of week must be between 0..6")
  end

  it "returns error if any of the list are outside possible range" do
    sub_expression = "10,27,78"
    permitted_range = (0..59)
    timescale_string = "minute"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    validator = SubExpressionValidator.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect { validator.valid? }.to raise_error(
      RuntimeError,
      "Request invalid, minute must be between 0..59")
  end

  it "returns error if any of the range are outside possible range" do
    sub_expression = "50-72"
    permitted_range = (0..59)
    timescale_string = "minute"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    validator = SubExpressionValidator.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      delimiter_describer: delimiter_describer,
      timescale_string: timescale_string)

    expect { validator.valid? }.to raise_error(
      RuntimeError,
      "Request invalid, minute must be between 0..59")
  end

  it "returns error if the explicit input is outside possible range" do
    sub_expression = "10"
    permitted_range = (0..6)
    timescale_string = "day of week"
    delimiter_describer = DelimiterDescriber.new(sub_expression: sub_expression)
    validator = SubExpressionValidator.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      delimiter_describer: delimiter_describer)

    expect { validator.valid? }.to raise_error(
      RuntimeError,
      "Request invalid, day of week must be between 0..6")
  end
end
