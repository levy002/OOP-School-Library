require './nameable'

class Person < Nameable
  def initialize(age, name = 'Unknown', parent_permission: true)
    super()
    @id = Random.rand(1..100)
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  attr_reader :id

  attr_accessor :name, :age

  def can_use_services?
    true if @age >= 18 || parent_permission == true
  end

  private

  def of_age?
    @age >= 18
  end

  def correct_name
    @name
  end
end
