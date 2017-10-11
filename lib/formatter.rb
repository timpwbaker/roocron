class Formatter

  attr_reader :sub_expression,
    :delimiter_describer,
    :permitted_range,
    :timescale_string

  def initialize(sub_expression:, delimiter_describer:, permitted_range:, timescale_string:)
    @permitted_range = permitted_range
    @timescale_string = timescale_string
    @sub_expression = sub_expression
    @delimiter_describer = delimiter_describer
  end

  def format
    formatted_string
  end

  private

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
      sub_expression
    end
  end

  def slash_formatter_divisor
    sub_expression.split("/").last.to_i
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
    sub_expression
      .split(",")
      .join(" ")
  end

  def range_formatter
    range_from_sub_expression
      .to_a
      .join(" ")
  end

  def range_from_sub_expression
    lowest, highest = sub_expression
      .split("-")
      .map(&:to_i)

    Range.new(lowest, highest)
  end
end
