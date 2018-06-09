class Order
  attr_accessor :book, :reader, :date

  def initialize(book, reader, date)
    @book = book
    @reader = reader
    @date = date
  end

  def to_h
    {
      book: book.title,
      reader: reader.name,
      date: date
    }
  end
end
