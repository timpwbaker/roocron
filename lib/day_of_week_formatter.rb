class DayOfWeekFormatter
  include SharedFormatter

  attr_reader :input_argument

  ENGLISH_HASH = {
    "sun" => "0",
    "mon" => "1",
    "tue" => "2",
    "wed" => "3",
    "thu" => "4",
    "fri" => "5",
    "sat" => "6"
  }

  def initialize(input_argument:)
    if ENGLISH_HASH[input_argument.downcase]
      @input_argument = ENGLISH_HASH[input_argument.downcase]
    else
      @input_argument = input_argument
    end
  end

  def format
    "#{formatted_descriptor("day of week")}#{output_formatter}"
  end

  private

  def wildcard
    (0..6)
  end
end
