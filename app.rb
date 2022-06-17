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
    puts "There are #{@books.length} books available"

    @books.each_with_index do |book, index|
      puts "#{index + 1}) Title: \"#{book.title}\" | Author: #{book.author}"
    end
  end

  def peoples_list
    puts 'No added people!! Please Add new person.' if @people.empty?
    puts "#{@people.length} peoples added."

    @people.each_with_index do |person, index|
      puts "#{index + 1})[#{person.class}] Name: #{person.name} | Age: #{person.age} | ID: #{person.id}"
    end
  end

  def create_person
    puts 'Would like to create student (1) or teacher (2)'
    choice = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Age:'
    age = gets.chomp.to_i

    case choice
    when '1'
      create_student(age: age, name: name)
    when '2'
      create_teacher(age: age, name: name)
    else
      puts 'Invalid. Please try again!'
    end
  end

  def create_student(age:, name:)
    puts 'Parent permission [Y/N]'
    choice = gets.chomp.downcase

    case choice
    when 'y'
      student = Student.new(age: age, name: name, parent_permission: true)
    when 'n'
      student = Student.new(age: age, name: name, parent_permission: false)
    else
      puts 'Invalid. Try again'
    end
    @people << student
    puts 'Student created successfully!!'
  end

  def create_teacher(age:, name:)
    puts 'Please add your specialization:'
    specialization = gets.chomp
    teacher = Teacher.new(age: age, name: name, specialization: specialization)
    @people << teacher
    puts 'Teacher created successfully!!'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp

    if title != '' && author != ''
      book = Book.new(title, author)
      @books << book
      puts 'Book created successfully!!'
    else
      puts 'Please Enter book title and author'
    end
  end

  def new_rental
    if @books.empty? && @people.empty?
      puts 'No books and People available'
    else
      puts 'Choose the number of the book you want to rent:'
      @books.each_with_index do |book, index|
        puts "#{index + 1}: Title: #{book.title} | Author: #{book.author}"
      end
      book_id = gets.chomp.to_i - 1
      choosen_book = @books[book_id]

      puts 'Type your ID:'
      @people.each do |person|
        puts "[#{person.class}] Name: #{person.name} | Age: #{person.age} | ID: #{person.id}"
      end
      renter_id = gets.chomp.to_i
      renter = @people.select { |person| person.id == renter_id }.first

      print 'Enter the date[yyyy-mm-dd]: '
      date = gets.chomp.to_s
      rental = Rental.new(date: date, person: renter, book: choosen_book)
      @rentals << rental
      puts 'Book rented successfully!!'
    end
  end

  def rental_list
    puts 'No rentals available!' if @rentals.empty?
    print 'To view your rentals, type your ID: '
    id = gets.chomp.to_i
    rental = @rentals.select { |rent| rent.person.id == id }
    if rental.empty?
      puts 'No rentals for this person'
    else
      puts 'Here are your records: '
      rental.each_with_index do |rcrd, index|
        puts "#{index + 1}| Date: #{rcrd.date} | Borrower: #{rcrd.person.name} | Status: #{rcrd.person.class} | Borrowed book: \"#{rcrd.book.title}\" by #{rcrd.book.author}"
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
