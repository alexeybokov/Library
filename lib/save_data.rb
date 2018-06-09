module SaveData
  def save(resourse)
    case resourse.class.name
    when 'Book'
      books.push(resourse) unless books.include?(resourse)
    when 'Order'
      orders.push(resourse)
    when 'Reader'
      readers.push(resourse)
    when 'Author'
      authors.push(resourse)
    end
  end

  def write_to_yaml(filename)
    File.open("#{filename}", 'w+') do |f|
      f.write(as_yaml)
    end
  end

  def as_yaml
    {
      library: {
          books: books.map(&:to_h), # .map { |book| book.to_h }
          readers: readers.map(&:to_h),
          orders: orders.map(&:to_h),
          authors: authors.map(&:to_h)
      }
    }.to_yaml
  end

  def self.restore_from_yaml(filename)
    parsed = YAML.load_file(filename)[:library]
    library = Library.new
    restore_authors(library, parsed[:authors])
    restore_books(library, parsed[:books])
    restore_readers(library, parsed[:readers])
    restore_orders(library, parsed[:orders])
    library
  end

  def self.restore_authors(library, parsed_authors)
    parsed_authors.each do |author_hash|
      library.save(Author.new(author_hash[:name], author_hash[:bio]))
    end
  end

  def self.restore_books(library, parsed_books)
    parsed_books.each do |book_hash|
      author = library.find_author(book_hash[:author])
      library.save(Book.new(book_hash[:title], author))
    end
  end

  def self.restore_readers(library, parsed_readers)
    parsed_readers.each do |reader_hash|
      reader = Reader.new(reader_hash[:name], reader_hash[:email])
      reader.set_address(reader_hash[:city], reader_hash[:street], reader_hash[:house])
      library.save(reader)
    end
  end

  def self.restore_orders(library, parsed_orders)
    parsed_orders.each do |order_hash|
      book = library.find_book(order_hash[:book])
      reader = library.find_reader(order_hash[:reader])
      order = Order.new(book, reader, order_hash[:date])
      library.save(order)
    end
  end

  # def save_books
  #   File.open("books.txt", "w") do |f|
  #     @books.each { |b| f.puts "#{b.title}:#{b.author}" }
  #   end
  # end
  #
  #
  # def read_books
  #   return unless File.exists?("books.txt")
  #   book_fields = File.readlines("books.txt")
  #   book_fields.map! { |b| b.chomp }
  #   book_fields.map! { |b| b.split(":") }
  #   book_fields.each { |b| @books << Book.new(b[0], b[1]) unless find_book(b[0]) }
  # end
end