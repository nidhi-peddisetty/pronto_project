require 'rspec'
require_relative '../src/Game'
require_relative '../src/Board'
require_relative '../src/Player'
require_relative '../SRC/Property'

RSpec.describe Game do
  let(:board_data) do
    [
      { "name" => "nandos", "price" => 1, "colour" => "Blue", "type" => "property" },
      { "name" => "MCD", "price" => 5, "colour" => "Yellow", "type" => "property" },
      { "name" => "KFC", "price" => 1, "colour" => "Blue", "type" => "property" }
    ]
  end

  let(:board) { Board.new(board_data) }
  let(:players) { [Player.new("A"), Player.new("B")] }
  let(:dice_rolls) { [1, 2, 1, 2, 1, 2] } #Testing rolls
  let(:game) { Game.new(players, board, dice_rolls) }



  describe "#initialize" do
    it "initializes with players, board, and dice rolls" do
      expect(game.instance_variable_get(:@players)).to eq(players)
      expect(game.instance_variable_get(:@board)).to eq(board)
      expect(game.instance_variable_get(:@dice_rolls)).to eq(dice_rolls)
    end
  end

  describe "#move_player" do
    it "moves the player correctly based on dice roll" do
      player = players.first
      game.move_player(player, 1)
      expect(player.position).to eq(1) # Should land on "MCD"
    end

    it "gives $1 when a player passes GO after the first round" do
      player = players.first
      player.position = 2  # Move player near the end of board
      game.move_player(player, 1) # Should wrap around to position 0 (nandos)
      expect(player.money).to eq(17) # Starts at $1, gains $1 after passing GO
    end
  end

  describe "#check_property" do
    it "allows a player to buy an unowned property" do
      player = players.first
      game.move_player(player, 0) # Lands on "nandos"
      game.check_property(player)
      expect(player.money).to eq(15) # Spent $1
      expect(board.spaces[0].owner).to eq(player) # Property should be owned
    end

    it "deducts rent when a player lands on an owned property" do
      player1 = players.first
      player2 = players.last
      game.move_player(player1, 0) # A bought "nandos"
      game.check_property(player1)

      game.move_player(player2, 0) # B lands on A's property
      game.check_property(player2)

      expect(player2.money).to eq(15) # B starts with $16, pays $1 rent
      expect(player2.bankrupt?).to be false
    end
  end

  describe "#game_over?" do
    it "returns true when only one player is left" do
      players.last.money = 0 # Make B bankrupt
      expect(game.game_over?).to be true
    end
  end

  describe "#play" do
    it "ends the game when a player goes bankrupt" do
      allow(game).to receive(:game_over?).and_return(true) #  game-over condition
      expect { game.play }.not_to raise_error
    end
  end
end
