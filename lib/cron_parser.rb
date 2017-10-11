class CronParser
  require_relative "definition_methods.rb"
  require_relative "delimiter_describer.rb"
  require_relative "expression.rb"
  require_relative "expression_validator.rb"
  require_relative "formatter.rb"
  require_relative "normalizer.rb"
  require_relative "sub_expression_validator.rb"

  include DefinitionMethods

  attr_reader :user_input

  def initialize(user_input:)
    @user_input = user_input
  end

  def parse
    expression_validator.validate

    generate_output
  end

  private

  def expression_validator
    ExpressionValidator.new(user_input: user_input)
  end

  def expression
    @_expression ||= Expression.new(user_input: user_input)
  end

  def minute_formatted_string
    Formatter.new(
      cron_sub_expression: expression.minute,
      permitted_range: minute_permitted_range,
      timescale_string: minute_timescale_string,
      delimiter_describer: delimiter_describer_for(expression.minute)
    ).format
  end

  def hour_formatted_string
    Formatter.new(
      cron_sub_expression: expression.hour,
      permitted_range: hour_permitted_range,
      timescale_string: hour_timescale_string,
      delimiter_describer: delimiter_describer_for(expression.hour)
    ).format
  end

  def day_of_month_formatted_string
    Formatter.new(
      cron_sub_expression: expression.day_of_month,
      permitted_range: day_of_month_permitted_range,
      timescale_string: day_of_month_timescale_string,
      delimiter_describer: delimiter_describer_for(expression.day_of_month)
    ).format
  end

  def month_formatted_string
    Formatter.new(
      cron_sub_expression: expression.month,
      permitted_range: month_permitted_range,
      timescale_string: month_timescale_string,
      delimiter_describer: delimiter_describer_for(expression.month)
    ).format
  end

  def day_of_week_formatted_string
    Formatter.new(
      cron_sub_expression: expression.day_of_week,
      permitted_range: day_of_week_permitted_range,
      timescale_string: day_of_week_timescale_string,
      delimiter_describer: delimiter_describer_for(expression.day_of_week)
    ).format
  end

  def command_formatted_string
    "command       #{expression.command}"
  end

  def delimiter_describer_for(cron_sub_expression)
    DelimiterDescriber.new(cron_sub_expression: cron_sub_expression)
  end

  def generate_output
    [
      minute_formatted_string,
      hour_formatted_string,
      day_of_month_formatted_string,
      month_formatted_string,
      day_of_week_formatted_string,
      command_formatted_string
    ].join("\n") + "\n"
  end
end
