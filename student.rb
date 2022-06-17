require './person'
require './classroom'

class Student < Person
  attr_reader :classroom

  def initialize(age, classroom, name = 'Unknown', parent_permission: true)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
    Classroom.add_students(self)
  end

  def play_hooky
    "¯\(ツ)/¯"
  end
end
