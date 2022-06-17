require './person'

class Student < Person
  attr_reader :classroom

  def initialize(age:, classroom: nil, name: 'Unknown', parent_permission: true)
    super(age: age, name: name, parent_permission: parent_permission)
    @classroom = classroom
    classroom&.add_students(self)
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
