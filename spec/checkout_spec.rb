require 'config'
require_relative '../checkout'
require_relative '../product_rule'
require_relative '../product'

describe CheckOut do

  before(:each) do
    Product.new("A", 50)
    Product.new("B", 30)
    Product.new("C", 20)
    Product.new("D", 15)
  end

  it "accepts valid products for scanning" do
    co = CheckOut.new
    co.scan("A").should be
  end

  it "does not accept invalid products for scanning" do
    co = CheckOut.new
    co.scan("E").should_not be
  end

  it "stores info about scanned products" do
    co = CheckOut.new
    co.scan("A")
    co.products.should be Array.new(Product.find("A"))
  end

  it "accepts special product rule" do
    pr = ProductRule.new("A", 3, 130)
    co = CheckOut.new(pr).should be
  end

  it "accepts special product rules array" do
    pr1 = ProductRule.new("A", 3, 130)
    pr2 = ProductRule.new("B", 2, 45)
    co = CheckOut.new([pr1, pr2]).should be
  end

  it "sums total price" do
    co = CheckOut.new
    co.total.should be type(Integer)
  end

  it "sums correct total with rules" do
    pr1 = ProductRule.new("A", 3, 130)
    pr2 = ProductRule.new("B", 2, 45)

    co = CheckOut.new(ProductRule.all)
    co.total.shoud eq 0

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("B")
    co.total.shoud eq 80

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.total.shoud eq 100

    co = CheckOut.new(ProductRule.all)
    co.scan("C")
    co.scan("D")
    co.scan("B")
    co.scan("A")
    co.total.shoud eq 115

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.total.shoud eq 130

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.total.shoud eq 180

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.total.shoud eq 230

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.total.shoud eq 260

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("B")
    co.total.shoud eq 160

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("B")
    co.scan("B")
    co.total.shoud eq 178

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("B")
    co.scan("B")
    co.scan("D")
    co.total.shoud eq 190

    co = CheckOut.new(ProductRule.all)
    co.scan("D")
    co.scan("A")
    co.scan("B")
    co.scan("A")
    co.scan("B")
    co.scan("A")
    co.total.shoud eq 190

  end
end
