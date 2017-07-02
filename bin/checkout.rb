require_relative '../checkout'
Product.new("A", 50)
Product.new("B", 30)
Product.new("C", 20)
Product.new("D", 15)
ProductRule.new("A", 3, 130)
ProductRule.new("B", 2, 45)
co = CheckOut.new(ProductRule.all)
puts "Scanning A"
co.scan("A")
puts "Total: #{co.total}"
puts "Scanning A"
co.scan("A")
puts "Total: #{co.total}"
puts "Scanning A"
co.scan("A")
puts "Total: #{co.total}"
puts "Scanning A"
co.scan("A")
puts "Total: #{co.total}"
puts "Scanning B"
co.scan("B")
puts "Total: #{co.total}"
puts "Scanning B"
co.scan("B")
puts "Total: #{co.total}"
puts "Scanning D"
co.scan("D")
puts "Total: #{co.total}"
puts "Scanning A"
co.scan("A")
puts "Total: #{co.total}"
puts "Scanning A"
co.scan("A")
puts "Total: #{co.total}"
