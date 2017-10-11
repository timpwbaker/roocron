class CronParser
  require_relative "definition_methods.rb"
  require_relative "delimiter_describer.rb"
  require_relative "expression.rb"
  require_relative "expression_validator.rb"
  require_relative "formatter.rb"
  require_relative "normalizer.rb"
  require_relative "sub_expression.rb"
  require_relative "sub_expression_validator.rb"

  include DefinitionMethods

  attr_reader :user_input

  def initialize(user_input:)
    @user_input = user_input
  end

  def parse
    if user_input
      generate_output
    else
      raise "There has been a problem, have you provided an input?"
    end
  end

  private

  def expression
    @_expression ||= Expression.new(user_input: user_input)
  end

  def generate_output
    expression.express
  end
end
