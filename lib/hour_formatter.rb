class HourFormatter
  attr_reader :input_argument

  def initialize(input_argument:)
    @input_argument = input_argument
  end

  def format
    if delimiter
      special_formatted_string
    else
      explicit_formatted_string
    end
  end

  private

  def formatted_descriptor
    @_formatted_descriptor ||= "%-14.14s" % "hour"
  end

  def delimiter
    @_delimirter ||= 
      delimiters.find{ |delimiter| input_argument.include?(delimiter) }
  end

  def explicit_formatted_string
    "#{formatted_descriptor}#{input_argument}"
  end

  def special_formatted_string
    "#{formatted_descriptor}#{special_hour_formatter}"
  end

  def special_hour_formatter
    if delimiter == "/"
      slash_formatter
    elsif delimiter == "*"
      star_formatter
    elsif delimiter == ","
      comma_formatter
    elsif delimiter == "-"
      range_formatter
    end
  end

  def slash_formatter
    devisor = input_argument.split("/").last.to_i
    wildcard.select{ |option| option%devisor == 0 }.join(" ")
  end

  def star_formatter
    wildcard.to_a.join(" ")
  end

  def comma_formatter
    input_argument.gsub(" ", "").gsub(",", " ")
  end

  def range_formatter
    array = input_argument.split("-")
    Range.new(array[0].to_i, array[1].to_i).to_a.join(" ")
  end

  def wildcard
    (0..23)
  end

  def delimiters
    ["/", ",", "*", "-"]
  end
end
