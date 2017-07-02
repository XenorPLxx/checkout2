require 'config'
require_relative '../product'
describe Product do

  it "initializes with only with valid name and price" do
    Product.new.should_not be
    Product.new("C", "A").should_not be
    Product.new("A", 50).should be
  end

  it "has unique name" do
    Product.new("A", 50).should be
    Product.new("A", 50).should_not be
  end

  it "finds product by name" do
    p1 = Product.new("A", 50)
    p2 = Product.new("B", 40)
    Product.find("A").should be p1
  end

end
