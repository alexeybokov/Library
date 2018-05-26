class Book < Library
  attr_accessor :title, :author

  def initialize(title, author)
    @title = title
    @author = author
  end

  def to_h
    {
      title: title,
      author: author.name
    }
  end
end