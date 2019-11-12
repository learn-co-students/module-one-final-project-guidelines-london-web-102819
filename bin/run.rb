require_relative '../config/environment'
require "pry"
cli = CLI.new
cli.greet

microsoft = Stock.find_or_create_by(symbol: "MSFT")
microsoft.save
amazon = Stock.find_or_create_by(symbol: "AMZN")
amazon.save
google = Stock.find_or_create_by(symbol: "GOOG")
google.save

portfolio = Portfolio.new
portfolio.save

portfolio.positions.create(stock_id: microsoft.id)

binding.pry
foo = "bar"

puts portfolio.total_value


puts "HELLO WORLD"
