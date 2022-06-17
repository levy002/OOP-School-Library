require './app'

puts 'Welcome to your personal library'

def main
  app = App.new
  app.start
end

def selecting
  case choices
  when '1'
    books_list
  when '2'
    peoples_list
  when '3'
    create_person
  when '4'
    create_book
  when '5'
    new_rental
  when '6'
    rentals_list
  when '7'
    puts 'Thank you for using the app. Goodbye!'
  else
    puts 'Invalid input. Try again'
  end
end

main
