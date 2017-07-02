require 'config'
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
    ProductRule.new.should_not be
    ProductRule.new("C", "A", "A").should_not be
    ProductRule.new("E", 3, 130).should_not be
    ProductRule.new("A", 3, 130).should be
  end

  it "is unique for product count" do
    ProductRule.new("A", 3, 130).should be
    ProductRule.new("A", 2, 90).should be
    ProductRule.new("A", 3, 140).should_not be
  end

  it "finds best rule by product name and count" do
    pr1 = ProductRule.new("A", 3, 130)
    pr2 = ProductRule.new("A", 2, 90)
    ProductRule.find("A", 5).should be pr1
    ProductRule.find("A", 3).should be pr1
    ProductRule.find("A", 2).should be pr2
    ProductRule.find("A", 1).should_not be
  end

end
