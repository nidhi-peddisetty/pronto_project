require_relative 'Property'

class Board
  attr_reader :spaces

  def initialize(board_data)
    @spaces = []
    load_spaces(board_data)
  end

  def load_spaces(board_data)
    board_data.each do |space_data|
      @spaces << Property.new(space_data['name'], space_data['price'], space_data['colour'], space_data['type'])
    end
  end

  def [](index)
    @spaces[index]
  end

  def size
    @spaces.size
  end
end
