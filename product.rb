class Product
  attr_accessor :name, :price
  @@all = []

  def initialize(name, price)
    if Product.find(name)
      raise "Product already exists!"
    end
    if price.class != Integer
      raise "Invalid price!"
    end
    @name = name
    @price = price
    @@all << self
  end

  def self.find(name)
    found = nil
    @@all.each do |product|
      if product.name == name
        found = product
        break
      end
    end
    found
  end
end
