class Formatter

  attr_reader :cron_sub_expression,
    :delimiter_describer,
    :permitted_range,
    :timescale_string

  def initialize(cron_sub_expression:, delimiter_describer:, permitted_range:, timescale_string:)
    @permitted_range = permitted_range
    @timescale_string = timescale_string
    @cron_sub_expression = cron_sub_expression
    @delimiter_describer = delimiter_describer
  end

  def format
    sub_expression_validator.validate

    valid_output_string
  end

  private

  def valid_output_string
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
      cron_sub_expression
    end
  end

  def slash_formatter_divisor
    cron_sub_expression.split("/").last.to_i
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
    cron_sub_expression
      .split(",")
      .join(" ")
  end

  def range_formatter
    range_from_sub_expression
      .to_a
      .join(" ")
  end

  def range_from_sub_expression
    lowest, highest = cron_sub_expression
      .split("-")
      .map(&:to_i)

    Range.new(lowest, highest)
  end

  def sub_expression_validator
    @_sub_expression_validator ||=
      SubExpressionValidator.new(sub_expression: cron_sub_expression,
                                 timescale_string: timescale_string,
                                 permitted_range: permitted_range,
                                 delimiter_describer: delimiter_describer)
  end
end
