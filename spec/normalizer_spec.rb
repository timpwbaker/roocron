require "spec_helper"

RSpec.describe Normalizer, ".initialize" do
  it "takes a cron sub expression and a normalization hash as arguments" do
    cron_sub_expression = "mon,tue"
    normalization_hash = day_of_week_hash
    delimiter = ","
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.cron_sub_expression).to eq "mon,tue"
    expect(normalizer.normalization_hash).to eq day_of_week_hash
  end
end

RSpec.describe Normalizer, "#normalize" do
  it "returns a normalized input from comma separated days" do
    cron_sub_expression = "mon,tue"
    delimiter = ","
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.normalize).to eq "1,2"
  end

  it "returns a normalized input from comma separated months" do
    cron_sub_expression = "jan,mar,aug"
    delimiter = ","
    normalization_hash = month_of_year_hash
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.normalize).to eq "1,3,8"
  end

  it "returns a normalized input from hyphen separated days" do
    cron_sub_expression = "mon-fri"
    delimiter = "-"
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.normalize).to eq "1-5"
  end

  it "returns a normalized input from hyphen separated months" do
    cron_sub_expression = "jan-mar"
    delimiter = "-"
    normalization_hash = month_of_year_hash
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.normalize).to eq "1-3"
  end

  it "returns a normalized input from single month" do
    cron_sub_expression = "oct"
    delimiter = nil
    normalization_hash = month_of_year_hash
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.normalize).to eq "10"
  end

  it "returns a normalized input from single day" do
    cron_sub_expression = "sat"
    delimiter = nil
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.normalize).to eq "6"
  end

  it "normalizes 7 to 0 (Sunday)" do
    cron_sub_expression = "7"
    normalization_hash = day_of_week_hash
    delimiter = nil
    normalizer = Normalizer.new(cron_sub_expression: cron_sub_expression,
                                normalization_hash: normalization_hash,
                                delimiter: delimiter)

    expect(normalizer.normalize).to eq "0"
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
