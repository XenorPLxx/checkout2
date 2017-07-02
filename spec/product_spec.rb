require_relative '../product'
describe Product do

  it "initializes with only with valid name and price" do
    expect{Product.new}.to raise_error
    expect(Product.new("C", "A")).to be
    expect(Product.new("A", 50)).to be
  end

  it "has unique name" do
    expect(Product.new("A", 50)).to be
    expect{Product.new("A", 50)}.to raise_error
  end

  it "finds product by name" do
    p1 = Product.new("A", 50)
    p2 = Product.new("B", 40)
    expect(Product.find("A")).to be p1
  end

end
