class Reader
  attr_accessor :name, :email, :city, :street, :house

  def initialize(name, email)
    @name = name
    @email = email
  end

  def set_address(city, street, house)
    @city = city
    @street = street
    @house = house
  end

  def to_h
    {
      name: name,
      email: email,
      city: city,
      street: street,
      house: house
    }
  end
end
