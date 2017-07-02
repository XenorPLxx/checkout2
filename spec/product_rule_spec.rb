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
    expect{ProductRule.new}.to raise_error ArgumentError
    expect{ProductRule.new("C", "A", "A")}.to raise_error ArgumentError
    expect{ProductRule.new("E", 3, 130)}.to raise_error RuntimeError
    expect(ProductRule.new("D", 3, 130)).to be
  end

  it "is unique for product count" do
    expect(ProductRule.new("C", 3, 130)).to be
    expect(ProductRule.new("C", 2, 90)).to be
    expect{ProductRule.new("C", 3, 140)}.to raise_error RuntimeError
  end

  it "finds best rule by product name and count" do
    ProductRule.new("A", 2, 90)
    expect(ProductRule.find_best("A", 5)).to be ProductRule.find("A", 3)
    expect(ProductRule.find_best("A", 3)).to be ProductRule.find("A", 3)
    expect(ProductRule.find_best("A", 2)).to be ProductRule.find("A", 2)
    expect(ProductRule.find_best("A", 1)).to_not be
  end

  it "finds best rule by product name and count for rules array" do
    arr = []
    arr << ProductRule.new("A", 5, 160)
    arr << ProductRule.new("A", 4, 160)
    expect(ProductRule.find_best("A", 6, arr)).to be ProductRule.find("A", 5)
    expect(ProductRule.find_best("A", 4, arr)).to be ProductRule.find("A", 4)
    expect(ProductRule.find_best("A", 2, arr)).to_not be
    expect(ProductRule.find_best("A", 1, arr)).to_not be
  end

end
