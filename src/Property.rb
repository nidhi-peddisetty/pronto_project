class Property
  attr_accessor :name, :price, :colour, :owner, :rent
  def initialize(name, price, colour, type)
    @name = name
    @price = price
    @colour = colour
    @type = type
    @owner = nil
    @rent = nil #calculate_rent method TBC
  end
end
