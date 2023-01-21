require 'rails_helper'

RSpec.describe Entity, type: :model do
  describe 'validations' do
    it 'is valid with a name and amount' do
      entity = Entity.new(name: 'Apple', amount: 10)
      expect(entity).to be_valid
    end

    it 'is invalid without a name' do
      entity = Entity.new(name: nil)
      entity.valid?
      expect(entity.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a negative amount' do
      entity = Entity.new(amount: -5)
      entity.valid?
      expect(entity.errors[:amount]).to include('must be greater than or equal to 0')
    end

    it 'is invalid with a non-integer amount' do
      entity = Entity.new(amount: 3.14)
      entity.valid?
      expect(entity.errors[:amount]).to include('must be an integer')
    end
  end

  describe 'association' do
    it 'has many categories' do
      assc = described_class.reflect_on_association(:categories)
      expect(assc.macro).to eq :has_many
    end
  end
end
