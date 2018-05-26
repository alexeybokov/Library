class FindMostActiveReader

  attr_reader :max_taken_books_num, :most_active_reader

  def initialize(library)
    @library = library
    @max_taken_books_num = 0
    @most_active_reader = nil
  end

  def perform
    find_the_most_active_reader
    self
  end

  private

  def find_the_most_active_reader
    frequency_hash = Hash.new { |hash, key| hash[key] = 0 }
    library.orders.each do |order|
      frequency_hash[order.reader] += 1
      if frequency_hash[order.reader] > @max_taken_books_num
        @most_active_reader = order.reader
        @max_taken_books_num = frequency_hash[order.reader]
      end
    end
  end

  attr_reader :library
end