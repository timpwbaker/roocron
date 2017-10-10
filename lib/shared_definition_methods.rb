module SharedDefinitionMethods
  def delimiters
    ["/", ",", "*", "-"]
  end

  def day_of_week_hash
    {
      "sun" => "0",
      "mon" => "1",
      "tue" => "2",
      "wed" => "3",
      "thu" => "4",
      "fri" => "5",
      "sat" => "6",
      "7" => "0"
    }
  end

  def month_of_year_hash
    {
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
  end

  def minute_permitted_range
    0..59
  end

  def hour_permitted_range
    0..23
  end

  def day_of_month_permitted_range
    1..31
  end

  def month_permitted_range
    1..12
  end

  def day_of_week_permitted_range
    0..6
  end

  def minute_timescale_string
    "minute"
  end

  def hour_timescale_string
    "hour"
  end

  def day_of_month_timescale_string
    "day of month"
  end

  def month_timescale_string
    "month"
  end

  def day_of_week_timescale_string
    "day of week"
  end
end
