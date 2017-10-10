module ValidationMethods
  def invalid_argument?
    empty_output? || output_outside_valid_range?
  end

  def empty_output?
    output_array.empty?
  end

  def output_outside_valid_range?
    (output_array - wildcard.to_a).any?
  end

  def invalid_argument_string
    "Request invalid, #{timescale_string} must be between #{wildcard}"
  end
end
