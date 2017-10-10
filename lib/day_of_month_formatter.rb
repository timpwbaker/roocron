class DayOfMonthFormatter
  include SharedFormatter

  attr_reader :input_argument

  def initialize(input_argument:)
    @input_argument = input_argument
  end

  def format
    "#{formatted_descriptor("day of month")}#{output_formatter}"
  end

  private

  def wildcard
    (1..31)
  end
end
