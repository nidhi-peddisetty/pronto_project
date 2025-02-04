class Game
  def initialize(players, board, dice_rolls)
    @players = players
    @board = board
    @dice_rolls = dice_rolls
    @current_player_index = 0
  end

  def play
    until game_over? # Loop game until one of the players goes bankrupt
      current_player = @players[@current_player_index]
      dice_roll = @dice_rolls.shift
      move_player(current_player, dice_roll)
      check_property(current_player)

      if current_player.bankrupt?
        winner = @players.max_by { |player| player.money }
        puts "Winner: #{winner.name}, with $#{winner.money}"
        break
      else
        @current_player_index = (@current_player_index + 1) % @players.size
      end
    end

    # Printing each game summary
    puts "\nGame Summary:"
    @players.each do |player|
      puts "#{player.name} ended with $#{player.money} on #{@board[player.position].name}"
    end
  end

  def move_player(player, roll)

    previous_position = player.position
    player.position = (player.position + roll) % @board.size

    if previous_position > player.position
      if player.completed_first_round == false
        player.money += 1
        # In line testing to check $1 reward when the player passes go from second round
        # puts "#{player.name} passes GO and collects $1"
      else
        player.completed_first_round = true
      end
    end
    # In line testing to check roll, position, money and appropriate player name for the relevant move
    # puts "#{player.name} rolls a #{roll} and lands on #{@board[player.position].name} has $#{player.money}"
  end

  def check_property(player)
    property = @board[player.position]

    # if player.position > 8 && player.previous_position == 0
    #   player.money += 1
    #   puts "#{player.name} passes GO and collects $1"
    # end

    player.previous_position = player.position

    if property.is_a?(Property) && property.name != "GO"
      if property.is_owned?
        rent = property.rent

        if owns_both_properties_in_colour_group(player, property)
          rent *= 2
          # Inline testing
          # puts "#{player.name} owns both properties in the color group, doubling the rent!"
        end

        property.pay_rent(player)
      else
        player.buy_property(property)
        property.owner = player
      end
    end
  end

  def owns_both_properties_in_colour_group(player, property)
    color_group = property.colour
    owned_properties = @board.spaces.select { |space| space.colour == color_group && space.is_owned? }
    owned_properties.count { |space| space.owner == player } == owned_properties.size
  end

  def game_over?
    @players.select { |player| !player.bankrupt? }.size <= 1
  end
end
