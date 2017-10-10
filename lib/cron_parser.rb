class CronParser
  require_relative "definition_methods.rb"
  require_relative "delimiter_describer.rb"
  require_relative "user_input_validator.rb"
  require_relative "normalizer.rb"
  require_relative "sub_expression.rb"
  require_relative "sub_expression_validator.rb"

  include DefinitionMethods

  attr_reader :user_input

  def initialize(user_input:)
    @user_input = user_input
  end

  def parse
    if user_input_valid?
      generate_output
    else
      raise "There has been a problem, have you provided an input?"
    end
  end

  private

  def user_input_valid?
    user_input_validator.validate
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
    SubExpression.new(sub_expression: sub_expressions.minute,
                      timescale_string: minute_timescale_string,
                      permitted_range: minute_permitted_range,
                      delimiter_describer: delimiter_describer_for(
                        sub_expressions.minute))
  end

  def hour
    SubExpression.new(sub_expression: sub_expressions.hour,
                      timescale_string: hour_timescale_string,
                      permitted_range: hour_permitted_range,
                      delimiter_describer: delimiter_describer_for(
                        sub_expressions.hour))
  end

  def day_of_month
    SubExpression.new(sub_expression: sub_expressions.day_of_month,
                      timescale_string: day_of_month_timescale_string,
                      permitted_range: day_of_month_permitted_range,
                      delimiter_describer: delimiter_describer_for(
                        sub_expressions.day_of_month))
  end

  def month
    SubExpression.new(sub_expression: normalized_month,
                      timescale_string: month_timescale_string,
                      permitted_range: month_permitted_range,
                      delimiter_describer: delimiter_describer_for(
                        normalized_month))
  end

  def day_of_week
    SubExpression.new(sub_expression: normalized_day_of_week,
                      timescale_string: day_of_week_timescale_string,
                      permitted_range: day_of_week_permitted_range,
                      delimiter_describer: delimiter_describer_for(
                        normalized_day_of_week))
  end

  def delimiter_describer_for(sub_expression)
    DelimiterDescriber.new(sub_expression: sub_expression)
  end

  def normalized_month
    Normalizer.new(
      sub_expression: sub_expressions.month,
      normalization_hash: month_of_year_hash).normalize
  end

  def normalized_day_of_week
    Normalizer.new(
      sub_expression: sub_expressions.day_of_week,
      normalization_hash: day_of_week_hash).normalize
  end

  def command
    sub_expressions.command
  end

  def command_formatted_string
    "command       #{command}"
  end

  def user_input_validator
    UserInputValidator.new(user_input: user_input)
  end

  def sub_expressions
    parts = user_input.split(" ")
    OpenStruct.new(
      minute: parts[0],
      hour: parts[1],
      day_of_month: parts[2],
      month: parts[3],
      day_of_week: parts[4],
      command: parts[5]
    )
  end
end
