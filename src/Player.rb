class Player
  attr_accessor :name, :money, :position, :properties, :previous_position, :completed_first_round

  def initialize(name)
    @name = name
    @money = 16
    @position = 0
    @properties = []
    @previous_position = 0
    @completed_first_round = false
  end

end
