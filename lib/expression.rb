class Expression
  include DefinitionMethods

  attr_reader :user_input

  def initialize(user_input:)
    @user_input = user_input
  end

  def minute
    user_input_array[0]
  end

  def hour
    user_input_array[1]
  end

  def day_of_month
    user_input_array[2]
  end

  def month
    Normalizer.new(
      cron_sub_expression: user_input_array[3],
      normalization_hash: month_of_year_hash).normalize
  end

  def day_of_week
    Normalizer.new(
      cron_sub_expression: user_input_array[4],
      normalization_hash: day_of_week_hash).normalize
  end

  def command
    user_input_array[5]
  end

  private

  def user_input_array
    user_input.split(" ")
  end
end
