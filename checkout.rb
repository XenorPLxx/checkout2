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
    @products = {}
  end

  def scan(name)
    p = Product.find(name)
    if p
      if @products[name]
        @products[name] += 1
      else
        @products[name] = 1
      end
      # puts "Product #{p.name} scanned, price: #{p.price}!"
      true
    else
      # puts "Invalid product!"
      false
    end
  end

  def total
    sum = 0
    puts
    puts @products.inspect
    @products.each do |product|
      if ProductRule.find_best
      end
      sum += Product.find(product[0]).price
    end
    puts "Total price is #{sum}"
    puts
    sum
  end

end
