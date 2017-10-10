require "spec_helper"

RSpec.describe DelimiterDescriber, ".initialize" do
  it "takes a cron sub expression as an argument" do
    cron_sub_expression = "1-2"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.cron_sub_expression).to eq "1-2"
  end
end

RSpec.describe DelimiterDescriber, "#delimiter" do
  it "returns the - delimiter as a string" do
    cron_sub_expression = "1-2"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.delimiter).to eq "-"
  end

  it "returns the / delimiter as a string" do
    cron_sub_expression = "*/2"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.delimiter).to eq "/"
  end

  it "returns the , delimiter as a string" do
    cron_sub_expression = "1,2"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.delimiter).to eq ","
  end
end

RSpec.describe DelimiterDescriber, "#slash_delimited?" do
  it "returns true for a slash delimited cron sub expression" do
    cron_sub_expression = "*/2"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.slash_delimited?).to eq true
    expect(delimiter_describer.comma_delimited?).to eq false
    expect(delimiter_describer.wildcard?).to eq false
    expect(delimiter_describer.hyphen_delimited?).to eq false
  end
end

RSpec.describe DelimiterDescriber, "#comma_delimited?" do
  it "returns true for a slash delimited cron sub expression" do
    cron_sub_expression = "1,2"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.comma_delimited?).to eq true
    expect(delimiter_describer.slash_delimited?).to eq false
    expect(delimiter_describer.wildcard?).to eq false
    expect(delimiter_describer.hyphen_delimited?).to eq false
  end
end

RSpec.describe DelimiterDescriber, "#hyphen_delimited?" do
  it "returns true for a slash delimited cron sub expression" do
    cron_sub_expression = "1-6"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.hyphen_delimited?).to eq true
    expect(delimiter_describer.comma_delimited?).to eq false
    expect(delimiter_describer.wildcard?).to eq false
    expect(delimiter_describer.slash_delimited?).to eq false
  end
end

RSpec.describe DelimiterDescriber, "#wildcard?" do
  it "returns true for a wildcard cron sub expression" do
    cron_sub_expression = "*"
    delimiter_describer = DelimiterDescriber.new(
      cron_sub_expression: cron_sub_expression)

    expect(delimiter_describer.wildcard?).to eq true
    expect(delimiter_describer.slash_delimited?).to eq false
    expect(delimiter_describer.hyphen_delimited?).to eq false
    expect(delimiter_describer.comma_delimited?).to eq false
  end
end
