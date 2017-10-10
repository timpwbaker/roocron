class UserInputValidator
  attr_reader :user_input

  def initialize(user_input:)
    @user_input = user_input
  end

  def validate
    validate_user_input
  end

  private

  def validate_user_input
    user_input && validate_length
  end

  def validate_length
    if invalid_length?
      raise invalid_cron_expression_string
    else
      true
    end
  end

  def invalid_length?
    user_input_as_array.length != 6
  end

  def user_input_as_array
    user_input.split(" ")
  end

  def invalid_cron_expression_string
    "Invalid input, the input should be 5 cron elements followed by"\
      " a command. For details please checkout the README"
  end
end
