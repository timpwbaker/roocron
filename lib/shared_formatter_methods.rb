module SharedFormatterMethods
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
      normalized_value(user_input)
    end
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

  def delimiter
    @_delimiter ||=
      delimiters.find{ |delimiter| user_input.include?(delimiter) }
  end

  def slash_formatter_divisor
    user_input.split("/").last.to_i
  end

  def slash_formatter
    permitted_range
      .select{ |option| option%slash_formatter_divisor == 0 }
      .join(" ")
  end

  def star_formatter
    permitted_range.to_a.join(" ")
  end

  def comma_formatter
    user_input
      .split(",")
      .map{ |element| normalized_value(element) }
      .join(" ")
  end

  def range_formatter
    normalized_range
      .to_a
      .join(" ")
  end

  def normalized_range
    lowest, highest = user_input
      .split("-")
      .map{|n| normalized_value(n).to_i }

    Range.new(lowest, highest)
  end

  def normalized_value(value)
    normalization_hash.fetch(value.downcase, value)
  end

  def output_array
    output_formatter.split(" ").map(&:to_i)
  end

  def valid_output_string
    "#{formatted_descriptor(timescale_string)}#{output_formatter}"
  end

  def explicit_formatted_string
    "#{formatted_descriptor("day of month")}#{user_input}"
  end

  def special_formatted_string
    "#{formatted_descriptor("day of month")}#{special_day_of_month_formatter}"
  end

  def formatted_descriptor(descriptor)
    @_formatted_descriptor ||= "%-14.14s" % descriptor
  end

  def timescale_string
    raise "You must pass a timescale_string argument your formatter"
  end

  def permitted_range
    raise "You must pass a permitted range argument to your formatter"
  end
end
