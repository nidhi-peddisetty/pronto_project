class Property
  attr_accessor :name, :price, :colour, :owner, :rent
  def initialize(name, price, colour, type)
    @name = name
    @price = price
    @colour = colour
    @type = type
    @owner = nil
    @rent = calculate_rent
  end
end
