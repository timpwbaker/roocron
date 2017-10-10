module SharedFormatter
  def explicit_formatted_string
    "#{formatted_descriptor("day of month")}#{input_argument}"
  end

  def special_formatted_string
    "#{formatted_descriptor("day of month")}#{special_day_of_month_formatter}"
  end

  def output_formatter
    if slash_delimited?
      slash_formatter
    elsif star_delimited?
      star_formatter
    elsif comma_delimited?
      comma_formatter
    elsif hyphen_delimited?
      range_formatter
    else
      input_argument
    end
  end

  def formatted_descriptor(descriptor)
    @_formatted_descriptor ||= "%-14.14s" % descriptor
  end

  def delimiter
    @_delimirter ||=
      delimiters.find{ |delimiter| input_argument.include?(delimiter) }
  end

  def delimiters
    ["/", ",", "*", "-"]
  end

  def slash_delimited?
    delimiter == "/"
  end

  def star_delimited?
    delimiter == "*"
  end

  def comma_delimited?
    delimiter == ","
  end

  def hyphen_delimited?
    delimiter == "-"
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
    raise "You must implement a wildcard in your formatter"
  end
end
