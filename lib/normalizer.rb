class Normalizer
  attr_reader :cron_sub_expression, :normalization_hash

  def initialize(cron_sub_expression:, normalization_hash:, delimiter:)
    @cron_sub_expression = cron_sub_expression
    @normalization_hash = normalization_hash
  end

  def normalize
    return cron_sub_expression if wildcard?
    normalized_string
  end

  private

  def wildcard?
    cron_sub_expression == "*"
  end

  def normalized_string
    normalized_array.join(delimiter)
  end

  def normalized_array
    cron_sub_expression_as_array.map{ |input| normalized_value(input) }
  end

  def cron_sub_expression_as_array
    cron_sub_expression.split(delimiter)
  end

  def delimiter_describer
    DelimiterDescriber.new(cron_sub_expression: cron_sub_expression)
  end

  def delimiter
    delimiter_describer.delimiter
  end

  def normalized_value(value)
    normalization_hash.fetch(value.downcase, value)
  end
end
