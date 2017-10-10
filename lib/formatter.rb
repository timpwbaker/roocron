class Formatter
  include SharedFormatterMethods
  include SharedDefinitionMethods
  include ValidationMethods

  attr_reader :user_input,
    :permitted_range,
    :timescale_string,
    :normalization_hash

  def initialize(user_input:, permitted_range:,
                 timescale_string:, normalization_hash: {})
    @normalization_hash = normalization_hash
    @permitted_range = permitted_range
    @timescale_string = timescale_string
    @user_input = user_input
  end

  def format
    raise invalid_argument_string if invalid_argument?

    valid_output_string
  end
end
