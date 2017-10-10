module ValidationMethods
  def invalid_cron_expression?
    wrong_length?
  end

  def wrong_length?
    user_input_array.length != 6
  end

  def invalid_cron_expression_string
    "Invalid input expression, the input should be 5 cron elements followed by"\
      " a command. For details please checkout the README"
  end
end
