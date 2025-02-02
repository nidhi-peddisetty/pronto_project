require 'rspec'
require_relative '../src/player'  # Assuming your Player class is in player.rb

RSpec.describe Player do
  describe '#initialize' do
    it 'initializes with the correct name' do
      player = Player.new('John')
      expect(player.name).to eq('John')
    end

    it 'initializes with 16 money' do
      player = Player.new('John')
      expect(player.money).to eq(16)
    end

    it 'initializes with position 0' do
      player = Player.new('John')
      expect(player.position).to eq(0)
    end

    it 'initializes with an empty properties array' do
      player = Player.new('John')
      expect(player.properties).to eq([])
    end
  end
end
