require './book'
require './classroom'
require './base_decorator'
require './person'
require './rental'
require './student'
require './teacher'

class App
  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def start
    selecting
  end

  def books_list
    puts 'No books available!!' if @books.empty?
    puts "There are #{@books.count} books available"

    @books.each_with_index do |book, index|
      puts "#{index + 1}) Title: \"#{book.title}\" | Author: #{book.author}"
    end
  end

  def peoples_list
    puts 'No added people!! Please Add new person.' if @people.empty?
    puts "#{@books.count} peoples added."

    @people.each_with_index do |person, index|
      puts "#{index + 1})[#{person.class}] Name: #{person.name} | Age: #{person.age} | ID: #{person.id}"
    end
  end

  def create_person
    print 'Would you like to create a student (1) or a teacher (2)? Select a number:'
    choice = gets.chomp
    print 'Name:'
    name = gets.chomp
    print 'Age:'
    age = gets.chomp.to_i
    case choice
    when '1'
      print 'Class:'
      classroom = gets.chomp
      create_student(age, classroom, name)
    when '2'
      print 'Specialization:'
      specialization = gets.chomp
      create_teacher(age, name, specialization)
    else
      puts 'Invalid, please try again'
    end
  end

  def create_student(age, classroom, name)
    print 'Parent permission? [Y/N]'
    option = gets.chomp.downcase
    case option
    when 'y'
      student = Student.new(age, classroom, name, parent_permission: true)
    when 'n'
      student = Student.new(age, classroom, name, parent_permission: false)
    else
      puts 'Invalid option, please try again'
      return
    end
    @people << student
    puts ''
    puts "Student is created successfully.Student ID is #{student.id}"
  end

  def create_teacher(age, name, specialization)
    teacher = Teacher.new(age, name, specialization)
    @people << teacher
    puts ''
    puts "Teacher created successfully. Teacher ID is #{teacher.id}"
  end

  def create_book
    print 'Title:'
    title = gets.chomp
    print 'Author:'
    author = gets.chomp

    if title.strip != '' && author.strip != ''
      book = Book.new(title, author)
      @books << book
      puts ''
      puts 'Book created successfully'
    else
      puts ''
      puts 'Enter book title and author'
    end
  end

  def new_rental
    if @books.empty? && @people.empty?
      puts 'Nothing to see here'
    else
      puts 'Press the number of the book you want: '
      @books.each_with_index do |book, indx|
        puts "#{indx + 1}) Title: \"#{book.title}\" | Author: #{book.author}"
      end
      number = gets.chomp.to_i
      index = number - 1

      puts 'Type your ID: '
      @people.each do |prsn|
        puts "[#{prsn.class}] Name: #{prsn.name} | Age: #{prsn.age} | ID: #{prsn.id}"
      end
      identity = gets.chomp.to_i

      individual = @people.select { |person| person.id == identity }.first

      print 'Enter the date[yyyy-mm-dd]: '
      date = gets.chomp.to_s
      rent = Rental.new(date, @book[index], individual)
      @rentals << rent
      puts 'Book rented successfully'
    end
  end

  def rentals_list
    puts 'No rentals available at the moment' if @rentals.empty?
    print 'To view your rentals, type your ID: '
    id = gets.chomp.to_i
    rental = @rentals.select { |rend| rend.person.id == id }
    if rental.empty?
      puts 'No records for that ID'
    else
      puts 'Here are your records: '
      puts ''
      rental.each_with_index do |rcrd, index|
        puts "#{index + 1}| Date: #{rcrd.date} | Borrower: #{rcrd.person.name}
            | Status: #{rcrd.person.class} | Borrowed book: \"#{rcrd.book.title}\" by #{rcrd.book.author}"
      end
    end
  end

  def choices
    puts "Please an option by selecting a number:
                        1. List all books
                        2. List all people
                        3. Create person account
                        4. Create a book
                        5. Create a rental
                        6. List all rentals for a given person ID
                        7. Exit"
    gets.chomp
  end
end
