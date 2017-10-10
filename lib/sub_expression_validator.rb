class SubExpressionValidator
  attr_reader :sub_expression

  def initialize(sub_expression:)
    @sub_expression = sub_expression
  end

  def valid?
    validate
  end

  private

  def timescale_string
    sub_expression.timescale_string
  end

  def permitted_range
    sub_expression.permitted_range
  end

  def delimiter_describer
    sub_expression.delimiter_describer
  end

  def sub_expression_string
    sub_expression.sub_expression_string
  end

  def validate
    if delimiter_describer.wildcard? || !invalid_sub_expression
      true
    else
      raise invalid_argument_string
    end
  end

  def invalid_argument_string
    "Request invalid, #{timescale_string} must be between #{permitted_range}"
  end

  def invalid_sub_expression
    slash_format_divisor_outside_permitted_range? ||
      output_outside_permitted_range?
  end

  def slash_format_divisor_outside_permitted_range?
    delimiter_describer.slash_delimited? &&
      !permitted_range.include?(delimiter_describer.slash_format_divisor)
  end

  def output_array
    sub_expression_string.split(delimiter_describer.delimiter).map(&:to_i)
  end

  def output_outside_permitted_range?
    (output_array - permitted_range.to_a).any?
  end
end
