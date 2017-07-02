require_relative '../product_rule'
require_relative '../product'

describe ProductRule do

  before(:all) do
    unless Product.find("A")
      Product.new("A", 50)
      Product.new("B", 30)
      Product.new("C", 20)
      Product.new("D", 15)
      ProductRule.new("A", 3, 130)
      ProductRule.new("B", 2, 45)
    end
  end

  it "initializes with only with valid product, count and price" do
    Product.new("Y", 90)
    expect{ProductRule.new}.to raise_error ArgumentError
    expect{ProductRule.new("C", "A", "A")}.to raise_error ArgumentError
    expect{ProductRule.new("E", 3, 130)}.to raise_error RuntimeError
    expect(ProductRule.new("Y", 3, 130)).to be
  end

  it "is unique for product count" do
    Product.new("T", 90)
    expect(ProductRule.new("T", 3, 130)).to be
    expect(ProductRule.new("T", 2, 90)).to be
    expect{ProductRule.new("T", 3, 140)}.to raise_error RuntimeError
  end

  it "finds best rule by product name and count" do
    Product.new("Z", 50)
    ProductRule.new("Z", 2, 90)
    ProductRule.new("Z", 3, 140)
    expect(ProductRule.find_best("Z", 5)).to be ProductRule.find("Z", 3)
    expect(ProductRule.find_best("Z", 3)).to be ProductRule.find("Z", 3)
    expect(ProductRule.find_best("Z", 2)).to be ProductRule.find("Z", 2)
    expect(ProductRule.find_best("Z", 1)).to_not be
  end

  it "finds best rule by product name and count for rules array" do
    Product.new("X", 50)
    arr = []
    arr << ProductRule.new("X", 5, 160)
    arr << ProductRule.new("X", 4, 160)
    ProductRule.new("X", 3, 10)
    expect(ProductRule.find_best("X", 6, arr)).to be ProductRule.find("X", 5)
    expect(ProductRule.find_best("X", 4, arr)).to be ProductRule.find("X", 4)
    expect(ProductRule.find_best("X", 2, arr)).to_not be
    expect(ProductRule.find_best("X", 1, arr)).to_not be
  end

end
