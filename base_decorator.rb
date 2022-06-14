require './nameable'

class BaseDecorator
  def initialize(nameable = nameable.new())
    super()
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end
