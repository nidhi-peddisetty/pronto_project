require 'rspec'
require_relative '../src/Property'  # Assuming your Property class is in property.rb

RSpec.describe Property do
  describe '#initialize' do
    it 'initializes with the correct name' do
      property = Property.new('Nandos', 1, 'blue', 'normal')
      expect(property.name).to eq('Nandos')
    end

    it 'initializes with the correct price' do
      property = Property.new('Nandos', 1, 'blue', 'normal')
      expect(property.price).to eq(1)
    end

    it 'initializes with the correct colour' do
      property = Property.new('Nandos', 1, 'blue', 'normal')
      expect(property.colour).to eq('blue')
    end

    it 'initializes with a nil owner' do
      property = Property.new('Nandos', 1, 'blue', 'normal')
      expect(property.owner).to be_nil
    end
  end
end
