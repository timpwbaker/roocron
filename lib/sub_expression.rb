class SubExpression
  include DefinitionMethods

  attr_reader :sub_expression_string,
    :timescale_string,
    :permitted_range,
    :delimiter_describer

  def initialize(sub_expression_string:, timescale_string:,
                 permitted_range:, delimiter_describer:)
    @sub_expression_string = sub_expression_string
    @timescale_string = timescale_string
    @permitted_range = permitted_range
    @delimiter_describer = delimiter_describer
  end

  def english_string
    if sub_expression_validator.valid?
      formatted_string
    else
      "The #{timescale_string} is incorrect, please check and try again"
    end
  end

  private

  def sub_expression_validator
    SubExpressionValidator.new(sub_expression: self)
  end

  def formatted_string
    "#{formatted_descriptor(timescale_string)}#{output_formatter}"
  end

  def formatted_descriptor(descriptor)
    @_formatted_descriptor ||= "%-14.14s" % descriptor
  end

  def output_formatter
    if delimiter_describer.slash_delimited?
      slash_formatter
    elsif delimiter_describer.wildcard?
      star_formatter
    elsif delimiter_describer.comma_delimited?
      comma_formatter
    elsif delimiter_describer.hyphen_delimited?
      range_formatter
    else
      sub_expression_string
    end
  end

  def slash_formatter_divisor
    sub_expression_string.split("/").last.to_i
  end

  def slash_formatter
    permitted_range
      .select{ |option| option%slash_formatter_divisor == 0 }
      .join(" ")
  end

  def star_formatter
    permitted_range.to_a.join(" ")
  end

  def comma_formatter
    sub_expression_string
      .split(",")
      .join(" ")
  end

  def range_formatter
    range_from_sub_expression
      .to_a
      .join(" ")
  end

  def range_from_sub_expression
    lowest, highest = sub_expression_string
      .split("-")
      .map(&:to_i)

    Range.new(lowest, highest)
  end
end
