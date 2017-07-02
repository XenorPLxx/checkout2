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
    expect(co.scan("A")).to be
  end

  it "does not accept invalid products for scanning" do
    co = CheckOut.new
    expect(co.scan("E")).to_not be
  end

  it "stores info about scanned products" do
    co = CheckOut.new
    co.scan("A")
    expect(co.products).to be Array.new(Product.find("A"))
  end

  it "accepts special product rule" do
    pr = ProductRule.new("A", 3, 130)
    expect(CheckOut.new(pr)).to be
  end

  it "accepts special product rules array" do
    pr1 = ProductRule.new("A", 3, 130)
    pr2 = ProductRule.new("B", 2, 45)
    expect(CheckOut.new([pr1, pr2])).to be
  end

  it "sums total price" do
    co = CheckOut.new
    expect(co.total).to be type(Integer)
  end

  it "sums correct total with rules" do
    pr1 = ProductRule.new("A", 3, 130)
    pr2 = ProductRule.new("B", 2, 45)

    co = CheckOut.new(ProductRule.all)
    expect(co.total).to eq 0

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("B")
    expect(co.total).to eq 80

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    expect(co.total).to eq 100

    co = CheckOut.new(ProductRule.all)
    co.scan("C")
    co.scan("D")
    co.scan("B")
    co.scan("A")
    expect(co.total).to eq 115

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    expect(co.total).to eq 130

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    expect(co.total).to eq 180

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    expect(co.total).to eq 230

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("A")
    expect(co.total).to eq 260

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("B")
    expect(co.total).to eq 160

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("B")
    co.scan("B")
    expect(co.total).to eq 178

    co = CheckOut.new(ProductRule.all)
    co.scan("A")
    co.scan("A")
    co.scan("A")
    co.scan("B")
    co.scan("B")
    co.scan("D")
    expect(co.total).to eq 190

    co = CheckOut.new(ProductRule.all)
    co.scan("D")
    co.scan("A")
    co.scan("B")
    co.scan("A")
    co.scan("B")
    co.scan("A")
    expect(co.total).to eq 190

  end
end
