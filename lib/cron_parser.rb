class CronParser
  require_relative "shared_methods.rb"
  require_relative "validation_methods.rb"
  require_relative "minute_formatter.rb"
  require_relative "hour_formatter.rb"
  require_relative "day_of_month_formatter.rb"
  require_relative "month_formatter.rb"
  require_relative "day_of_week_formatter.rb"

  include SharedMethods

  attr_reader :input_argument

  def initialize(input_argument:)
    @input_argument = input_argument
  end

  def parse
    generate_output
  end

  private

  def minute_formatted_string
    MinuteFormatter.new(input_argument: minute).format
  end

  def hour_formatted_string
    HourFormatter.new(input_argument: hour).format
  end

  def day_of_month_formatted_string
    DayOfMonthFormatter.new(input_argument: day_of_month).format
  end

  def month_formatted_string
    MonthFormatter.new(input_argument: month).format
  end

  def day_of_week_formatted_string
    DayOfWeekFormatter.new(input_argument: day_of_week).format
  end

  def command_formatted_string
    "#{formatted_descriptor("command")}#{command}"
  end

  def minute
    input_argument_array[0]
  end

  def hour
    input_argument_array[1]
  end

  def day_of_month
    input_argument_array[2]
  end

  def month
    input_argument_array[3]
  end

  def day_of_week
    input_argument_array[4]
  end

  def command
    input_argument_array[5]
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

  def input_argument_array
    input_argument.split(" ")
  end
end
