class Expression
  include DefinitionMethods

  attr_reader :user_input

  def initialize(user_input:)
    @user_input = user_input
  end

  def express
    if valid?
      generate_output
    else
      "There is a probem with your expression, please check and try again"
    end
  end

  private

  def valid?
    expression_validator.validate
  end

  def generate_output
    [
      minute.english_string,
      hour.english_string,
      day_of_month.english_string,
      month.english_string,
      day_of_week.english_string,
      command_formatted_string
    ].join("\n") + "\n"
  end

  def minute
    SubExpression.new(sub_expression: user_input_array[0],
                      timescale_string: minute_timescale_string,
                      permitted_range: minute_permitted_range)
  end

  def hour
    SubExpression.new(sub_expression: user_input_array[1],
                      timescale_string: hour_timescale_string,
                      permitted_range: hour_permitted_range)
  end

  def day_of_month
    SubExpression.new(sub_expression: user_input_array[2],
                      timescale_string: day_of_month_timescale_string,
                      permitted_range: day_of_month_permitted_range)
  end

  def month
    SubExpression.new(sub_expression: normalized_month,
                      timescale_string: month_timescale_string,
                      permitted_range: month_permitted_range)
  end

  def day_of_week
    SubExpression.new(sub_expression: normalized_day_of_week,
                      timescale_string: day_of_week_timescale_string,
                      permitted_range: day_of_week_permitted_range)
  end

  def normalized_month
    Normalizer.new(
      sub_expression: user_input_array[3],
      normalization_hash: month_of_year_hash).normalize
  end

  def normalized_day_of_week
    Normalizer.new(
      sub_expression: user_input_array[4],
      normalization_hash: day_of_week_hash).normalize
  end

  def command
    user_input_array[5]
  end

  def command_formatted_string
    "command       #{command}"
  end

  def expression_validator
    ExpressionValidator.new(user_input: user_input)
  end

  def user_input_array
    user_input.split(" ")
  end
end
