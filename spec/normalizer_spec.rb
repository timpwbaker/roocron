require "spec_helper"

RSpec.describe Normalizer, ".initialize" do
  it "takes a cron sub expression and a normalization hash as arguments" do
    sub_expression = "mon,tue"
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)


    expect(normalizer.sub_expression).to eq "mon,tue"
    expect(normalizer.normalization_hash).to eq day_of_week_hash
  end
end

RSpec.describe Normalizer, "#normalize" do
  it "returns a normalized input from comma separated days" do
    sub_expression = "mon,tue"
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)

    expect(normalizer.normalize).to eq "1,2"
  end

  it "returns a normalized input from comma separated months" do
    sub_expression = "jan,mar,aug"
    normalization_hash = month_of_year_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)

    expect(normalizer.normalize).to eq "1,3,8"
  end

  it "returns a normalized input from hyphen separated days" do
    sub_expression = "mon-fri"
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)

    expect(normalizer.normalize).to eq "1-5"
  end

  it "returns a normalized input from hyphen separated months" do
    sub_expression = "jan-mar"
    normalization_hash = month_of_year_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)

    expect(normalizer.normalize).to eq "1-3"
  end

  it "returns a normalized input from single month" do
    sub_expression = "oct"
    normalization_hash = month_of_year_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)

    expect(normalizer.normalize).to eq "10"
  end

  it "returns a normalized input from single day" do
    sub_expression = "sat"
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)

    expect(normalizer.normalize).to eq "6"
  end

  it "normalizes 7 to 0 (Sunday)" do
    sub_expression = "7"
    normalization_hash = day_of_week_hash
    normalizer = Normalizer.new(sub_expression: sub_expression,
                                normalization_hash: normalization_hash)

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
