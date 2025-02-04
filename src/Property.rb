class Property
  attr_accessor :name, :price, :colour, :owner, :rent
  def initialize(name, price, colour, type)
    @name = name
    @price = price
    @colour = colour
    @type = type
    @owner = nil # Initializing with no owner for the first round
    @rent = calculate_rent # Method calculate_rent to determine rent for each property
  end

  def calculate_rent
    case @price # Calculates rent based on json file's price attribute
    when 1..4 then @price
    else 0
    end
  end

  def is_owned?
    !@owner.nil?
  end

  def pay_rent(player)
    if is_owned?
      rent_to_pay = @rent
      rent_to_pay *= 2 if owner_has_both_properties?(@owner) # Double rent if both coloured properties are owned
      amount_left = player.money
      player.pay_rent(rent_to_pay)
      @owner.money += if amount_left < rent_to_pay
                        amount_left
                      else
                        rent_to_pay
                      end
      #In line testing code block to check rent, own money of the player
      # if player.bankrupt? == false
      #   puts "#{player.name} pays $#{rent_to_pay} rent to #{@owner.name}"
      #   puts "#{player.name} has $#{player.money} left and #{@owner.name} has $#{@owner.money} left"
      # end
    end
  end

  def owner_has_both_properties?(owner)
    owned_properties = owner.properties.select { |prop| prop.colour == @colour }
    owned_properties.size == 2 # Adjusting the colour group size to 2 based on raw data
  end
end
