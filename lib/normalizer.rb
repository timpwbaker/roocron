class Normalizer
  attr_reader :sub_expression, :normalization_hash

  def initialize(sub_expression:, normalization_hash:)
    @sub_expression = sub_expression
    @normalization_hash = normalization_hash
  end

  def normalize
    return sub_expression if wildcard?
    normalized_string
  end

  private

  def wildcard?
    sub_expression == "*"
  end

  def normalized_string
    normalized_array.join(delimiter)
  end

  def normalized_array
    sub_expression_as_array.map{ |input| normalized_value(input) }
  end

  def sub_expression_as_array
    sub_expression.split(delimiter)
  end

  def delimiter_describer
    DelimiterDescriber.new(sub_expression: sub_expression)
  end

  def delimiter
    delimiter_describer.delimiter
  end

  def normalized_value(value)
    normalization_hash.fetch(value.downcase, value)
  end
end
