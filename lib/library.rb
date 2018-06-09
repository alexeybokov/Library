require './save_data'

class Library
  include SaveData
  attr_accessor :books, :orders, :readers, :authors

  def initialize
    @books = []
    @orders = []
    @readers = []
    @authors = []
  end

  def find_author(author_name)
    found_author = authors.find { |author| author.name == author_name }
    fail "Author #{author_name} wasn't found!" unless found_author
    found_author
  end

  def find_book(book_title)
    found_book = books.find { |book| book.title == book_title }
    fail "Book #{book_title} wasn't found!" unless found_book
    found_book
  end

  def find_reader(reader_name)
    found_reader = readers.find { |reader| reader.name == reader_name }
    fail "reader #{reader_name} wasn't found!" unless found_reader
    found_reader
  end
end
