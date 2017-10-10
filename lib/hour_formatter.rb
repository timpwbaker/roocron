class HourFormatter
  include SharedMethods

  attr_reader :input_argument

  def initialize(input_argument:)
    @input_argument = input_argument
  end

  def format
    "#{formatted_descriptor("hour")}#{output_formatter}"
  end

  private

  def wildcard
    (0..23)
  end
end
