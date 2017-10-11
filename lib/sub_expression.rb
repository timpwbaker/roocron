class SubExpression
  include DefinitionMethods

  attr_reader :sub_expression,
    :timescale_string,
    :permitted_range

  def initialize(sub_expression:, timescale_string:, permitted_range:)
    @sub_expression = sub_expression
    @timescale_string = timescale_string
    @permitted_range = permitted_range
  end

  def english_string
    if sub_expression_validator.valid?
      format_string
    else
      "The #{timescale_string} is incorrect, please check and try again"
    end
  end

  private

  def sub_expression_validator
      SubExpressionValidator.new(
        sub_expression: sub_expression,
        timescale_string: timescale_string,
        permitted_range: permitted_range,
        delimiter_describer: delimiter_describer
      )
  end


  def format_string
    Formatter.new(
      sub_expression: sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      delimiter_describer: delimiter_describer
    ).format
  end

  def delimiter_describer
    DelimiterDescriber.new(sub_expression: sub_expression)
  end
end
