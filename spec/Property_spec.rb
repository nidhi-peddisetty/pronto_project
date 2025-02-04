require 'rspec'
require_relative '../src/property'
require_relative '../src/player' # As Player class is needed for rent calculation

RSpec.describe Property do
  let(:property) { Property.new('nandos', 1, 'Blue', 'property') }
  let(:player) { Player.new('A') }
  let(:owner) { Player.new('B') }

  describe '#initialize' do
    it 'initializes with the correct attributes' do
      expect(property.name).to eq('nandos')
      expect(property.price).to eq(1)
      expect(property.colour).to eq('Blue')
      expect(property.owner).to be_nil
      expect(property.rent).to eq(1) #price range (for 1..4 range)
    end
  end

  describe '#is_owned?' do
    it 'returns false if property has no owner' do
      expect(property.is_owned?).to be false  #set to nil intiallly
    end

    it 'returns true if property is owned' do
      property.owner = owner
      expect(property.is_owned?).to be true
    end
  end

  describe '#pay_rent' do
    before do
      property.owner = owner
      owner.properties << property
    end

    it 'deducts rent from player when owned' do
      initial_money = player.money
      property.pay_rent(player)
      expect(player.money).to eq(initial_money - property.rent)
      expect(owner.money).to eq(16 + property.rent)  # Owner receives rent
    end

    it 'does not deduct rent if property is not owned' do
      property.owner = nil
      initial_money = player.money
      property.pay_rent(player)
      expect(player.money).to eq(initial_money)
    end

    it 'doubles the rent if owner has both properties of the same color' do
      second_property = Property.new('KFC', 1, 'Blue', 'property')
      second_property.owner = owner
      owner.properties << second_property  # Owner has both blue properties

      initial_money = player.money
      property.pay_rent(player)
      expect(player.money).to eq(initial_money - (property.rent * 2)) # Double rent
    end

    it 'prevents player money from going negative' do
      player.money = 1
      property.pay_rent(player)
      expect(player.money).to eq(0)
      expect(owner.money).to eq(16 + 1)  # Owner only gets remaining money
    end
  end

  describe '#owner_has_both_properties?' do
    it 'returns false if owner has only one property of the color' do
      property.owner = owner
      owner.properties << property
      expect(property.owner_has_both_properties?(owner)).to be false
    end

    it 'returns true if owner has both properties of the same color' do
      second_property = Property.new('KFC', 1, 'Blue', 'property')
      second_property.owner = owner
      owner.properties << property
      owner.properties << second_property
      expect(property.owner_has_both_properties?(owner)).to be true
    end
  end
end
