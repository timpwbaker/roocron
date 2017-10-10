class DelimiterDescriber
  attr_reader :sub_expression

  def initialize(sub_expression:)
    @sub_expression = sub_expression
  end

  def slash_delimited?
    delimiter == "/"
  end

  def wildcard?
    sub_expression == "*"
  end

  def comma_delimited?
    delimiter == ","
  end

  def hyphen_delimited?
    delimiter == "-"
  end

  def slash_format_divisor
    slash_delimited? && sub_expression.split("/").last.to_i
  end

  def delimiter
    @_delimter ||= permitted_delimiters.find{ |delimiter|
      sub_expression.include?(delimiter) }
  end

  private

  def permitted_delimiters
    # This must stay in this order in order for */3 style expressions to be
    # evaluated correctly
    ["/", ",", "*", "-"]
  end
end
