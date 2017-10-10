class MonthFormatter
  include SharedFormatter

  attr_reader :input_argument

   ENGLISH_HASH = {
     "jan" => "1",
     "feb" => "2",
     "mar" => "3",
     "apr" => "4",
     "may" => "5",
     "jun" => "6",
     "jul" => "7",
     "aug" => "8",
     "sep" => "9",
     "oct" => "10",
     "nov" => "11",
     "dec" => "12",
  }

  def initialize(input_argument:)
    if ENGLISH_HASH[input_argument.downcase]
      @input_argument = ENGLISH_HASH[input_argument.downcase]
    else
      @input_argument = input_argument
    end
  end

  def format
    "#{formatted_descriptor("month")}#{output_formatter}"
  end

  private

  def wildcard
    (1..12)
  end
end
