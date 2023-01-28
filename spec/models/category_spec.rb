require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'validations' do
    it 'is valid with a name and image' do
      category = Category.new(name: 'Fruits', image: Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/images/apple.jpg'), 'image/jpg'))
      expect(category).to be_valid
    end

    it 'is invalid without a name' do
      category = Category.new(name: nil)
      category.valid?
      expect(category.errors[:name]).to include("can't be blank")
    end

    it 'is invalid without an image' do
      category = Category.new(image: nil)
      category.valid?
      expect(category.errors[:image]).to include("can't be blank")
    end
  end
  describe 'association' do
    it 'has many entities' do
      assc = described_class.reflect_on_association(:entities)
      expect(assc.macro).to eq :has_many
    end
    it 'has many category_entities' do
      assc = described_class.reflect_on_association(:category_entities)
      expect(assc.macro).to eq :has_many
    end
  end
end
