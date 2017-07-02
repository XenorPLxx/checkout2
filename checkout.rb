require_relative 'product_rule'
require_relative 'product'

class CheckOut
  attr_accessor :product_rules, :products
  def initialize(product_rules = nil)
    if product_rules.kind_of?(Array)
      @product_rules = product_rules
    elsif product_rules.kind_of?(ProductRule)
      @product_rules = []
      @product_rules << product_rules
    end
    @products = []
  end

  def scan(name)
    p = Product.find(name)
    if p
      @products << Product.find(name)
      puts "Product #{p.name} scanned, price: #{p.price}!"
      true
    else
      puts "Invalid product!"
      false
    end
  end

  def total
    sum = 0
    @products.each do |product|
      sum += product.price
    end
    puts "Total price is #{sum}"
    sum
  end

end
