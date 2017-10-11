require "spec_helper"

RSpec.describe Expression, ".initialize" do
  it "takes a valid user input as an argument" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.user_input).to eq "*/15 0 1,15 * 1-5 /usr/bin/find"
  end
end

RSpec.describe Expression, "#minute" do
  it "returns the minute portion of the expression" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.minute).to eq "*/15"
  end
end

RSpec.describe Expression, "#hour" do
  it "returns the hour portion of the expression" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.hour).to eq "0"
  end
end

RSpec.describe Expression, "#day_of_month" do
  it "returns the day of month portion of the expression" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.day_of_month).to eq "1,15"
  end
end

RSpec.describe Expression, "#month" do
  it "returns the month portion of the expression" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.month).to eq "*"
  end
end

RSpec.describe Expression, "#day_of_week" do
  it "returns the day of week portion of the expression" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.day_of_week).to eq "1-5"
  end
end
RSpec.describe Expression, "#command" do
  it "returns the command portion of the expression" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    expression = Expression.new(user_input: user_input)

    expect(expression.command).to eq "/usr/bin/find"
  end
end
