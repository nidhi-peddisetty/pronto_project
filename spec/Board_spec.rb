require 'rspec'
require_relative '../src/board'
require_relative '../src/property'
RSpec.describe Board do
  describe '#initialize' do
    it 'loads spaces correctly from board_data' do
      board_data = [
        { 'name' => 'Nandos', 'price' => 1, 'colour' => 'blue', 'type' => 'normal' },
        { 'name' => 'KFC', 'price' => 2, 'colour' => 'blue', 'type' => 'normal' }
      ]

      board = Board.new(board_data)

      expect(board.size).to eq(2)
      expect(board[0].name).to eq('Nandos')
      expect(board[1].name).to eq('KFC')
    end
  end

  describe '#[]' do
    it 'returns the correct space by index' do
      board_data = [
        { 'name' => 'Nandos', 'price' => 1, 'colour' => 'blue', 'type' => 'normal' }
      ]
      board = Board.new(board_data)

      expect(board[0].name).to eq('Nandos')
    end
  end

  describe '#size' do
    it 'returns the correct number of spaces' do
      board_data = [
        { 'name' => 'Nandos', 'price' => 1, 'colour' => 'blue', 'type' => 'normal' },
        { 'name' => 'KFC', 'price' => 2, 'colour' => 'blue', 'type' => 'normal' }
      ]
      board = Board.new(board_data)

      expect(board.size).to eq(2)
    end
  end
end
