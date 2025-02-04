require 'json'
require_relative "Board"
require_relative "Player"
require_relative "Game"

def play_game(dice_rolls_file, game_number) #Function to handle multiple dice rolls inputs
  board_data = JSON.parse(File.read('./data/board.json'))
  dice_rolls_data = JSON.parse(File.read(dice_rolls_file))

  board = Board.new(board_data)

  #Defining players
  players = [Player.new("Peter"), Player.new("Billy"), Player.new("Charlotte"), Player.new("Sweedal")]

  game = Game.new(players, board, dice_rolls_data)

  puts "\n---Start of Game Number: #{game_number}---"
  game.play
  puts "---End of Game #{game_number}---\n\n"
end

play_game('./data/rolls_1.json', 1)

play_game('./data/rolls_2.json', 2)
