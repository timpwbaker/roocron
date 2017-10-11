require "spec_helper"

RSpec.describe SubExpression, ".initialize" do
  it "takes a valid sub expression as an argument" do
    sub_expression = "*/15"
    timescale_string = "minute"
    permitted_range = (0..59)

    expression = SubExpression.new(
      sub_expression: sub_expression,
      timescale_string: timescale_string,
      permitted_range: permitted_range)

    expect(expression.sub_expression).to eq "*/15"
    expect(expression.timescale_string).to eq "minute"
    expect(expression.permitted_range).to eq (0..59)
  end
end
