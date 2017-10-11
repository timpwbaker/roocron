require "spec_helper"

RSpec.describe SubExpressionValidator, ".initialize" do
  it "takes a sub expression and a range as an argument" do
    sub_expression = "1-4"
    permitted_range = (1..90)
    timescale_string = "minute"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: sub_expression)
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
  it "returns true if the sub expression is valid" do
    valid_sub_expressions = ["1-4", "*/6", "1", "mon", "Fri", "WEDS", "jun", "Aug", "aug-sept", "1,2,7"]
    timescale_string = "minute"
    permitted_range = (0..59)

    valid_sub_expressions.each do |sub_expression|
      delimiter_describer = DelimiterDescriber.new(
        cron_sub_expression: sub_expression)
      validator = SubExpressionValidator.new(
        sub_expression: sub_expression,
        permitted_range: permitted_range,
        timescale_string: timescale_string,
        delimiter_describer: delimiter_describer)

      expect(validator.validate).to be true
    end
  end

  it "returns false if the sub expression is not valid" do
    invalid_sub_expressions = ["", "190", "*/70", "55-60", "1,6,90"]
    timescale_string = "minute"
    permitted_range = (0..59)

    invalid_sub_expressions.each do |sub_expression|
      delimiter_describer = DelimiterDescriber.new(
        cron_sub_expression: sub_expression)
      validator = SubExpressionValidator.new(
        sub_expression: sub_expression,
        permitted_range: permitted_range,
        timescale_string: timescale_string,
        delimiter_describer: delimiter_describer)

      expect{validator.validate}.to raise_error(
      RuntimeError,
      "Request invalid, minute must be between 0..59")
    end
  end
end
