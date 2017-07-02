class ProductRule
  attr_accessor :name, :count, :price
  @@all = []

  def self.all
    @@all
  end

  def initialize(name, count, price)
    if ProductRule.find(name, count)
      raise "ProductRule for that product and count already exists!"
    end
    raise ArgumentError.new "Invalid price!" if price.class != Integer
    raise ArgumentError.new "Invalid count!" if count.class != Integer
    raise "Product doesn't exist!" unless Product.find(name)
    @name = name
    @count = count
    @price = price
    @@all << self
  end

  def self.find(name, count)
    found = nil
    @@all.each do |product_rule|
      if product_rule.name == name and product_rule.count == count
        found = product_rule
        break
      end
    end
    found
  end

  def self.find_best(name, count)
    found = nil
    @@all.each do |product_rule|
      if product_rule.name == name and product_rule.count <= count
        if (!found.nil? and found.count < product_rule.count) or found.nil?
          found = product_rule
        end
      end
    end
    found
  end
end
