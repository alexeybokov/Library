class FindMostPopularBook
  def self.perform(library, places_number: 1)
    new(library, places_number: places_number).perform
  end

  def initialize(library, places_number: 1)
    @library = library
    @places_number = places_number
  end

  def perform
    sorted_frequencies = sort_frequency_hash(build_frequency_hash)
    find_n_most_popular(sorted_frequencies)
  end

  private

  def build_frequency_hash
    frequency_hash = Hash.new { |hash, key| hash[key] = 0 }
    library.orders.each { |order| frequency_hash[order.book] += 1 }
    frequency_hash
  end

  def sort_frequency_hash(frequency_hash)
    frequency_hash.sort_by { |_key, value| value }.reverse
  end

  def find_n_most_popular(sorted_frequencies)
    (0...places_number).map do |position|
      sorted_frequencies[position]
    end
  end

  attr_reader :library, :places_number
end

