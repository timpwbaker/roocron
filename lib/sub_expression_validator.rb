class SubExpressionValidator
  attr_reader :sub_expression, :permitted_range

  def initialize(sub_expression:, permitted_range:, delimiter_describer:)
    @sub_expression = sub_expression
    @permitted_range = permitted_range
    @delimiter_describer = delimiter_describer
  end

  def valid?
    delimiter_describer.wildcard? || !invalid_sub_expression
  end

  def invalid_response
    invalid_argument_string
  end

  private

  def invalid_sub_expression
    slash_format_divisor_outside_permitted_range? ||
      empty_output? || output_outside_permitted_range?
  end

  def slash_format_divisor_outside_permitted_range?
    delimiter_describer.slash_delimited? && 
      !permitted_range.include?(delimiter_describer.slash_format_divisor)
  end

  def empty_output?
    output_array.empty?
  end

  def output_array
    sub_expression.split(delimiter_describer.delimiter).map(&:to_i)
  end

  def output_outside_permitted_range?
    (output_array - permitted_range.to_a).any?
  end

  def delimiter_describer
    @_delimiter_describer ||= DelimiterDescriber.new(
      cron_sub_expression: sub_expression)
  end
end
