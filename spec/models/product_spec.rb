require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new(name: 'Sample Category')
    end

    it 'saves successfully when all fields are set' do
      product = Product.new(name: 'Name', price_cents: 100, quantity: 5, category: @category)
      expect(product).to be_valid
    end

    it 'fails validation when name is not set' do
      product = Product.new(name: nil, price_cents: 100, quantity: 5, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    it 'fails validation when price is not set' do
      product = Product.new(name: 'Name', price_cents: nil, quantity: 5, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    it 'fails validation when quantity is not set' do
      product = Product.new(name: 'Name', price_cents: 100, quantity: nil, category: @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'fails validation when category is not set' do
      product = Product.new(name: 'Name', price_cents: 100, quantity: 5, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
