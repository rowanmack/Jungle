require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it 'should save when all fields are entered' do
      @category = Category.new(:name => "Cactus")
      product = Product.create(:name => "Prickly Pear", :price => 20, :quantity => 10, :category => @category)
      expect(product).to be_valid
    end

    # validates :name, presence: true
    it 'should check theres a name' do
      @category = Category.new(:name => "Cactus")
      product = Product.create(:name => nil, :price => 10, :quantity => 25, :category => @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Name can't be blank")
    end

    # validates :price, presence: true
    it 'should check theres a price' do
      @category = Category.new(:name => "Cactus")
      product = Product.create(:name => "Peyote", :price_cents => nil, :quantity => 25, :category => @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Price can't be blank")
    end

    # validates :quantity, presence: true
    it 'should check theres a quantity' do
      @category = Category.new(:name => "Cactus")
      product = Product.create(:name => "Barbary Fig", :price => 10, :quantity => nil, :category => @category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Quantity can't be blank")
    end

    # validates :category, presence: true
    it 'should check theres a category' do
      @category = Category.new(:name => "Cactus")
      product = Product.create(:name => "Saguaro", :price => 10, :quantity => 25, :category => nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to include("Category can't be blank")
    end
  end
end

# validates :name, presence: true
# # validates :price, presence: true
# # validates :quantity, presence: true
# validates :category, presence: true