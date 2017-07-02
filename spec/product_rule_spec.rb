require_relative '../product_rule'
require_relative '../product'

describe ProductRule do

  before(:each) do
    Product.new("A", 50)
    Product.new("B", 30)
    Product.new("C", 20)
    Product.new("D", 15)
  end

  it "initializes with only with valid product, count and price" do
    expect{ProductRule.new}.to_raise error
    expect{ProductRule.new("C", "A", "A")}.to_raise error
    expect{ProductRule.new("E", 3, 130)}.to_raise error
    expect(ProductRule.new("A", 3, 130)).to be
  end

  it "is unique for product count" do
    expect(ProductRule.new("A", 3, 130)).to be
    expect(ProductRule.new("A", 2, 90)).to be
    expect{ProductRule.new("A", 3, 140)}.to_raise error
  end

  it "finds best rule by product name and count" do
    pr1 = ProductRule.new("A", 3, 130)
    pr2 = ProductRule.new("A", 2, 90)
    expect(ProductRule.find("A", 5)).to be pr1
    expect(ProductRule.find("A", 3)).to be pr1
    expect(ProductRule.find("A", 2)).to be pr2
    expect(ProductRule.find("A", 1)).to_not be
  end

end
