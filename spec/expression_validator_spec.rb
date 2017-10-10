require "spec_helper"

RSpec.describe UserInputValidator, ".initialize" do
  it "takes a user inputted command as an argument" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    user_input_validator = UserInputValidator.new(user_input: user_input)

    expect(user_input_validator.user_input).to eq "*/15 0 1,15 * 1-5 /usr/bin/find"
  end
end

RSpec.describe UserInputValidator, "#validate" do
  it "returns true for valid expressions" do
    user_input = "*/15 0 1,15 * 1-5 /usr/bin/find"
    user_input_validator = UserInputValidator.new(user_input: user_input)

    expect(user_input_validator.validate).to eq true
  end
end

RSpec.describe UserInputValidator, "#validate" do
  it "returns an error for invalid expressions" do
    user_input = "* * * * /usr/bin/find"
    user_input_validator = UserInputValidator.new(user_input: user_input)

    expect { user_input_validator.validate }.to raise_error(
      RuntimeError,
      "Invalid input, the input should be 5 cron elements followed by a command. For details please checkout the README")
  end
end
