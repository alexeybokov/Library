class FindReadersNumberForBook
  def self.perform(library, book)
    new(library, book).perform
  end

  def initialize(library, book)
    @library = library
    @book = book
  end

  def perform
    find_the_number_of_readers
  end

  private

  def find_the_number_of_readers
    book_readers = []
    library.orders.each do |order|
      book_readers.push(order.reader) if new_reader?(book_readers, order)
    end
    book_readers.size
  end

  def new_reader?(found_readers, order)
    order.book == book && !found_readers.include?(order.reader)
  end

  attr_reader :library, :book
end