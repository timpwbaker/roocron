class Formatter
  include SharedDefinitionMethods
  include ValidationMethods

  attr_reader :cron_sub_expression,
    :permitted_range,
    :timescale_string,
    :normalization_hash,
    :delimiter_describer

  def initialize(cron_sub_expression:, permitted_range:,
                 timescale_string:, normalization_hash: {})
    @normalization_hash = normalization_hash
    @permitted_range = permitted_range
    @timescale_string = timescale_string
    @delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)
    @cron_sub_expression = normalized_cron_sub_expression(cron_sub_expression)
  end

  def format
    raise invalid_argument_string if invalid_argument?

    valid_output_string
  end

  private

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

  def invalid_argument?
    !sub_expression_validator.valid?
  end

  def sub_expression_validator
    @_sub_expression_validator ||= 
      SubExpressionValidator.new(sub_expression: cron_sub_expression,
                                 permitted_range: permitted_range,
                                 delimiter_describer: delimiter_describer)
  end

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

  def normalized_cron_sub_expression(expression)
    Normalizer.new(
      cron_sub_expression: expression,
      normalization_hash: normalization_hash,
      delimiter: delimiter_describer.delimiter).normalize
  end
end
