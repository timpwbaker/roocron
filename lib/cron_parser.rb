class CronParser
  require_relative "shared_definition_methods.rb"
  require_relative "validation_methods.rb"
  require_relative "normalizer.rb"
  require_relative "delimiter_describer.rb"
  require_relative "formatter.rb"

  include SharedDefinitionMethods
  include ValidationMethods

  attr_reader :user_input

  def initialize(user_input:)
    @user_input = user_input
  end

  def parse
    raise invalid_cron_expression_string if invalid_cron_expression?

    generate_output
  end

  private

  def minute_formatted_string
    Formatter.new(
      cron_sub_expression: minute,
      permitted_range: minute_permitted_range,
      timescale_string: minute_timescale_string
    ).format
  end

  def hour_formatted_string
    Formatter.new(
      cron_sub_expression: hour,
      permitted_range: hour_permitted_range,
      timescale_string: hour_timescale_string
    ).format
  end

  def day_of_month_formatted_string
    Formatter.new(
      cron_sub_expression: day_of_month,
      permitted_range: day_of_month_permitted_range,
      timescale_string: day_of_month_timescale_string
    ).format
  end

  def month_formatted_string
    Formatter.new(
      cron_sub_expression: month,
      permitted_range: month_permitted_range,
      timescale_string: month_timescale_string,
      normalization_hash: month_of_year_hash
    ).format
  end

  def day_of_week_formatted_string
    Formatter.new(
      cron_sub_expression: day_of_week,
      permitted_range: day_of_week_permitted_range,
      timescale_string: day_of_week_timescale_string,
      normalization_hash: day_of_week_hash
    ).format
  end

  def command_formatted_string
    "command       #{command}"
  end

  def minute
    user_input_array[0]
  end

  def hour
    user_input_array[1]
  end

  def day_of_month
    user_input_array[2]
  end

  def month
    user_input_array[3]
  end

  def day_of_week
    user_input_array[4]
  end

  def command
    user_input_array[5]
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

  def user_input_array
    user_input.split(" ")
  end
end
