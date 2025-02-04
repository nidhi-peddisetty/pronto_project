class Player
  attr_accessor :name, :money, :position, :properties, :previous_position, :completed_first_round

  def initialize(name)
    @name = name
    @money = 16 #All Players start with $16
    @position = 0 #Position Go initialized as 0
    @properties = [] #List of owned properties
    @previous_position = 0
    @completed_first_round = false #Intial round on the board to calculate extra money received when they pass Go again
  end

  def bankrupt?
    @money <= 0
  end

  def pay_rent(amount)
    if @money >= amount
      @money -= amount
    else
      @money = 0
      #In line testing statement to check if the person is bankrupt
      # puts "#{@name} is bankrupt!"
    end
  end

  def buy_property(property)
    if @money >= property.price
      @money -= property.price
      @properties << property
      #In line testing statement to check property purchase logic
      # puts "#{@name} buys #{property.name} for $#{property.price} and has $#{@money} left"
    else
      #In line testing statement to check property purchase logic
      # puts "#{@name} doesn't have enough money to buy #{property.name}"
    end
  end
end
