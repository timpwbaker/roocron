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
      formatted_string(minutes),
      formatted_string(hours),
      formatted_string(days_of_month),
      formatted_string(months),
      formatted_string(days_of_week),
      command_formatted_string
    ].join("\n") + "\n"
  end

  def formatted_string(sub_expressions)
    "#{formatted_descriptor(sub_expressions.string)}#{sub_expressions.output}"
  end

  def formatted_descriptor(descriptor)
    "%-14.14s" % descriptor
  end

  def minutes
    sub_expressions_struct(string: minute_timescale_string,
                           sub_expressions: sub_expressions.minutes,
                           permitted_range: minute_permitted_range)
  end

  def hours
    sub_expressions_struct(string: hour_timescale_string,
                           sub_expressions: sub_expressions.hours,
                           permitted_range: hour_permitted_range)
  end

  def days_of_month
    sub_expressions_struct(string: day_of_month_timescale_string,
                           sub_expressions: sub_expressions.days_of_month,
                           permitted_range: day_of_month_permitted_range)
  end

  def months
    sub_expressions_struct(string: month_timescale_string,
                           sub_expressions: sub_expressions.months,
                           permitted_range: month_permitted_range)
  end

  def days_of_week
    sub_expressions_struct(string: day_of_week_timescale_string,
                           sub_expressions: sub_expressions.days_of_week,
                           permitted_range: day_of_week_permitted_range)
  end

  def sub_expressions_struct(string:, sub_expressions:, permitted_range:)
    OpenStruct.new(
      string: string,
      output: sub_expressions.map{ |sub_expression|
        SubExpression.new(sub_expression: sub_expression,
                          timescale_string: string,
                          permitted_range: permitted_range,
                          delimiter_describer: delimiter_describer_for(
                            sub_expression)).output
      }.join(" ")
    )
  end

  def delimiter_describer_for(sub_expression)
    DelimiterDescriber.new(sub_expression: sub_expression)
  end

  def normalized_month(month)
    Normalizer.new(
      sub_expression: month,
      normalization_hash: month_of_year_hash).normalize
  end

  def normalized_day_of_week(day_of_week)
    Normalizer.new(
      sub_expression: day_of_week,
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
      minutes: parts[0].split(","),
      hours: parts[1].split(","),
      days_of_month: parts[2].split(","),
      months: parts[3].split(",").map{ |month| normalized_month(month) },
      days_of_week: parts[4].split(",").map{ |day| normalized_day_of_week(day) },
      command: parts[5]
    )
  end
end
