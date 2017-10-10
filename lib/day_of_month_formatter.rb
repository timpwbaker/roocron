class DayOfMonthFormatter
  include SharedMethods
  include ValidationMethods

  attr_reader :input_argument

  def initialize(input_argument:)
    @input_argument = input_argument
  end

  def format
    raise invalid_argument_string if invalid_argument?

    valid_output_string
  end

  private

  def timescale_string
    "day of month"
  end

  def wildcard
    (1..31)
  end
end
