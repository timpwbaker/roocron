require "spec_helper"

RSpec.describe Formatter, ".initialize" do
  it "accepts a timescale string, a permitted range, a user input and english hash" do
    cron_sub_expression = "*/15"
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect(formatter.cron_sub_expression).to eq cron_sub_expression
    expect(formatter.permitted_range).to eq permitted_range
    expect(formatter.timescale_string).to eq timescale_string
  end

  it "converts user input if a compatible translation hash is provided" do
    cron_sub_expression = "sun"
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      normalization_hash: day_of_week_hash)

    expect(formatter.cron_sub_expression).to eq "0"
    expect(formatter.permitted_range).to eq (0..6)
    expect(formatter.timescale_string).to eq "day of week"
    expect(formatter.normalization_hash).to eq day_of_week_hash
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for a */15 style input" do
    cron_sub_expression = "*/15"
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect(formatter.format).to eq "minute        0 15 30 45"
  end

  it "returns error if divisor is outside possible range" do
    cron_sub_expression = "*/15"
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, day of week must be between 0..6")
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for a * (wildcard) input" do
    cron_sub_expression = "*"
    permitted_range = (0..23)
    timescale_string = "hour"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect(formatter.format).to eq(
      "hour          0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23"
    )
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for a comma separated list style input" do
    cron_sub_expression = "10,27,31"
    permitted_range = (1..31)
    timescale_string = "day of month"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect(formatter.format).to eq(
      "day of month  10 27 31"
    )
  end

  it "converts using the normalization hash if required" do
    cron_sub_expression = "MON,WED"
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      normalization_hash: day_of_week_hash)
expect(formatter.format).to eq(
      "day of week   1 3"
    )
  end

  it "returns error if any of the list are outside possible range" do
    cron_sub_expression = "10,27,78"
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, minute must be between 0..59")
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for hyphenated range style input" do
    cron_sub_expression = "25-32"
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect(formatter.format).to eq(
      "minute        25 26 27 28 29 30 31 32"
    )
  end

  it "normalizes the input if required and returns the correct string" do
    cron_sub_expression = "Jan-Mar"
    permitted_range = (1..12)
    timescale_string = "month"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      normalization_hash: month_of_year_hash)

    expect(formatter.format).to eq(
      "month         1 2 3"
    )
  end

  it "returns error if any of the list are outside possible range" do
    cron_sub_expression = "50-72"
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, minute must be between 0..59")
  end
end

RSpec.describe Formatter, "#format" do
  it "returns a formatted string for an explicit input" do
    cron_sub_expression = "12"
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect(formatter.format).to eq(
      "minute        12"
    )
  end

  it "returns a formatted string for an acceptable english user day input" do
    cron_sub_expression = "sun"
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      normalization_hash: day_of_week_hash)

    expect(formatter.format).to eq(
      "day of week   0"
    )
  end

  it "returns a formatted string for an acceptable english user month input" do
    cron_sub_expression = "jan"
    permitted_range = (1..12)
    timescale_string = "month"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      normalization_hash: month_of_year_hash)

    expect(formatter.format).to eq "month         1"
  end

  it "accepts a user input of 7 and treats it as 0 (sunday)" do
    cron_sub_expression = "7"
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      normalization_hash: day_of_week_hash)

    expect(formatter.format).to eq "day of week   0"
  end

  it "returns error if the explicit input is outside possible range" do
    cron_sub_expression = "10"
    permitted_range = (0..6)
    timescale_string = "day of week"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string,
      normalization_hash: day_of_week_hash)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, day of week must be between 0..6 or sun mon tue wed thu fri sat 7")
  end

  it "returns error if the explicit input is outside possible range" do
    cron_sub_expression = "72"
    permitted_range = (0..59)
    timescale_string = "minute"
    formatter = Formatter.new(
      cron_sub_expression: cron_sub_expression,
      permitted_range: permitted_range,
      timescale_string: timescale_string)

    expect{formatter.format}.to raise_error(
      RuntimeError,
      "Request invalid, minute must be between 0..59")
  end
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
