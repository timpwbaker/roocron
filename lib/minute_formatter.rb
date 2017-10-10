class MinuteFormatter
  include SharedMethods

  attr_reader :input_argument

  def initialize(input_argument:)
    @input_argument = input_argument
  end

  def format
    "#{formatted_descriptor("minute")}#{output_formatter}"
  end

  private

  def wildcard
    (0..59)
  end
end
