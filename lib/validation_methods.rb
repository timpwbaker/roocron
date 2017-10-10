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

  def invalid_argument?
    slash_format_divisor_outside_valid_range? ||
      empty_output? || output_outside_valid_range?
  end

  def empty_output?
    output_array.empty?
  end

  def output_outside_valid_range?
    (output_array - permitted_range.to_a).any?
  end

  def slash_format_divisor_outside_valid_range?
    slash_delimited? && !permitted_range.include?(slash_formatter_divisor)
  end

  def invalid_argument_string
    "Request invalid, #{timescale_string} must be between #{valid_options}"
  end

  def valid_options
    if normalization_hash.empty?
      permitted_range
    else
      "#{permitted_range} or #{normalization_hash.map{ |key, _| key }.join(" ")}"
    end
  end
end
