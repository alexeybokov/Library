require './lib/reader'
require './lib/order'
require './lib/author'
require './lib/file_worker'
require './lib/library_backup_manager'
require './lib/library'
require './lib/book'
require './lib/find_most_active_reader'
require './lib/find_most_popular_book'
require './lib/find_readers_number_for_book'

library = Library.new

author1 = Author.new('F.Scott Fitzerald', 'text_biography')
author2 = Author.new('J. R. R. Tolkien', 'text_biography')
author3 = Author.new('Mikhail Bulgakov', 'text_biography')

library.save_resource(author1)
library.save_resource(author2)
library.save_resource(author3)

book1 = Book.new('The Great Gatsby', author1)
book2 = Book.new('The Lord of the Rings', author2)
book3 = Book.new('The Master and Margarita', author3)
book4 = Book.new('Book 4', author3)
book5 = Book.new('Book 5', author3)

library.save_resource(book1)
library.save_resource(book2)
library.save_resource(book3)
library.save_resource(book4)
library.save_resource(book5)


reader1 = Reader.new('Alexey', 'alexey@gmail.com')
reader1.set_address('Dnipro', 'Gagarina', '8')
reader2 = Reader.new('Anna', 'anna@gmail.com')
reader2.set_address('Dnipro', 'Nova', '35')
reader3 = Reader.new('Pavel', 'pavel@gmail.com')
reader3.set_address('Odessa', 'Great', '69')
reader4 = Reader.new('Viktoriya', 'viktoriya@gmail.com')
reader4.set_address('Lviv', 'Green', '16')
reader5 = Reader.new('Dmitriy', 'dima@gmail.com')
reader5.set_address('Kyiv', 'Nezalezhna', '112')

library.save_resource(reader1)
library.save_resource(reader2)
library.save_resource(reader3)
library.save_resource(reader4)
library.save_resource(reader5)

order1 = Order.new(book1, reader1, '01/18/05')
order2 = Order.new(book2, reader2, '02/19/05')
order3 = Order.new(book2, reader3, '03/20/05')
order4 = Order.new(book3, reader4, '04/19/05')
order5 = Order.new(book4, reader1, '05/18/05')
order6 = Order.new(book5, reader5, '06/18/05')
order7 = Order.new(book5, reader5, '07/18/05')
order8 = Order.new(book5, reader1, '08/18/05')

library.save_resource(order1)
library.save_resource(order2)
library.save_resource(order3)
library.save_resource(order4)
library.save_resource(order5)
library.save_resource(order6)
library.save_resource(order7)
library.save_resource(order8)

puts "++++++++++++++++ROUND 1 ++++++++++++++++++++++++++"
most_active_reader_finder = FindMostActiveReader.new(library)
most_active_reader_finder.perform

puts "The most active reader is: #{most_active_reader_finder.most_active_reader.name}"
puts "He has read #{most_active_reader_finder.max_taken_books_num} books in total."

puts "-----------------------------------"

most_popular_books = FindMostPopularBook.perform(library, places_number: 3)
puts "The most popular books are:\n\n"
most_popular_books.each_with_index do |book, index|
  puts "#{index + 1}. #{book[0].title} - was taken #{book[1]} times"
  number_of_readers = FindReadersNumberForBook.perform(library, book[0])
  puts "Was read by #{number_of_readers} people\n\n"
end

puts "-----------------------------------"

# puts "Initial library state:"
# puts "=============================="
# puts library.inspect
# library.save_backup

# puts "After recovering:"
# puts "=============================="
library = Library.restore_from_backup
# puts library.inspect



puts "++++++++++++++++ROUND 2 ++++++++++++++++++++++++++"
most_active_reader_finder = FindMostActiveReader.new(library)
most_active_reader_finder.perform

puts "The most active reader is: #{most_active_reader_finder.most_active_reader.name}"
puts "He has read #{most_active_reader_finder.max_taken_books_num} books in total."

puts "-----------------------------------"

most_popular_books = FindMostPopularBook.perform(library, places_number: 3)
puts "The most popular books are:\n\n"
most_popular_books.each_with_index do |book, index|
  puts "#{index + 1}. #{book[0].title} - was taken #{book[1]} times"
  number_of_readers = FindReadersNumberForBook.perform(library, book[0])
  puts "Was read by #{number_of_readers} people\n\n"
end

puts "-----------------------------------"

# library.save_books
# library.read_books

