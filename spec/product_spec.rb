require_relative '../product'
describe Product do

  it "initializes with only with valid name and price" do
    expect{Product.new}.to raise_error ArgumentError
    expect{Product.new("E", "A")}.to raise_error ArgumentError
    expect(Product.new("E", 50)).to be
  end

  it "has unique name" do
    expect(Product.new("F", 50)).to be
    expect{Product.new("F", 50)}.to raise_error RuntimeError
  end

  it "finds product by name" do
    p1 = Product.new("G", 50)
    p2 = Product.new("H", 40)
    expect(Product.find("G")).to be p1
  end

end
