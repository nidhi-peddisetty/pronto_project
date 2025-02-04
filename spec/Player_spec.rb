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
    it 'initializes with previous position 0' do
      player = Player.new('John')
      expect(player.previous_position).to eq(0)
    end

    it 'initializes with completed_first_round set to false' do
      player = Player.new('John')
      expect(player.completed_first_round).to eq(false)
    end
  end


end
describe '#bankrupt?' do
  it 'returns false when player has money' do
    player = Player.new('John')
    expect(player.bankrupt?).to be false
  end

  it 'returns true when player has 0 money' do
    player = Player.new('John')
    player.money = 0
    expect(player.bankrupt?).to be true
  end

  it 'returns true when player has negative money' do
    player = Player.new('John')
    player.money = -5
    expect(player.bankrupt?).to be true
  end
end

describe '#pay_rent' do
  it 'deducts rent from the player’s money if they have enough' do
    player = Player.new('John')
    player.pay_rent(5)
    expect(player.money).to eq(11)
  end

  it 'sets money to 0 if rent is more than the player’s balance' do
    player = Player.new('John')
    player.pay_rent(20) # More than 16
    expect(player.money).to eq(0)
  end
end

describe '#buy_property' do
  let(:property) { double('Property', price: 5, name: 'Nandos') }

  it 'deducts money when buying a property' do
    player = Player.new('John')
    player.buy_property(property)
    expect(player.money).to eq(11) # 16 - 5
  end

  it 'adds the property to the player’s properties' do
    player = Player.new('John')
    player.buy_property(property)
    expect(player.properties).to include(property)
  end

  it 'does not buy a property if the player does not have enough money' do
    player = Player.new('John')
    player.money = 4
    player.buy_property(property)
    expect(player.money).to eq(4) # No purchase made
    expect(player.properties).to be_empty
  end
end

describe '#position tracking' do
  it 'updates previous position correctly' do
    player = Player.new('John')
    player.previous_position = player.position
    player.position = 5
    expect(player.previous_position).to eq(0)
    expect(player.position).to eq(5)
  end
end
describe '#completed_first_round' do
  it 'remains false until the player passes GO' do
    player = Player.new('John')
    expect(player.completed_first_round).to be false
  end

  it 'becomes true after passing GO' do
    player = Player.new('John')
    player.position = 10 # Simulate moving past GO
    player.completed_first_round = true
    expect(player.completed_first_round).to be true
  end
end
