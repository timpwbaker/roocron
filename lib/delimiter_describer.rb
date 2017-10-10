class DelimiterDescriber
  attr_reader :cron_sub_expression

  def initialize(cron_sub_expression:)
    @cron_sub_expression = cron_sub_expression
  end

  def delimiter
    @_delimiter ||=
      delimiters.find{ |delimiter| cron_sub_expression.include?(delimiter) }
  end

  def slash_delimited?
    delimiter == "/"
  end

  def wildcard?
    cron_sub_expression == "*"
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

  private

  def delimiters
    ["/", ",", "*", "-"]
  end
end
