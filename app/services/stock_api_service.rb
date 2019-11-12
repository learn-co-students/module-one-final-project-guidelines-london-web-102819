require 'open-uri'   
require 'json' 
require 'pry'

#  class StockApiService

  @api_key = "09KS2T8J28FSB9QP"

  def time_series_daily(symbol)
    content = open("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=#{@api_key}").read
    JSON.parse(content)
  end

  def latest_price(symbol)
    time_series = time_series_daily(symbol)["Time Series (Daily)"]
    latest_data = time_series.first
    close_price = latest_data[1]["4. close"].to_f.round(2)
  end




#  end

# binding.pry 
# 0

 #https://ruby-doc.org/stdlib-2.6.3/libdoc/open-uri/rdoc/OpenURI.html




# class StockApiService
#   @@price_cache = {}

#   def initialize(api_key = "09KS2T8J28FSB9QP")
#     @api_key = api_key
#   end

#   def time_series_daily(symbol)
#     content = open("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=#{@api_key}").read
#     JSON.parse(content)
#     #JSON.parse() to convert text into a JavaScript object
#   end

#   def latest_price(symbol)
#     if !@@price_cache.include?(symbol) 
#       time_series = time_series_daily(symbol)["Time Series (Daily)"] #the whole hash
#       binding.pry
#       recent_day, recent_day_data = time_series.first  #get the first key pair of the hash
#       close_price = recent_day_data["4. close"] #get the value of the key named "4. close"
#       @@price_cache[symbol] = close_price.to_f   
#     end
#     @@price_cache[symbol]
#   end

#   def latest_price_for_stock(stock)
#     latest_price(stock.symbol)
#   end

#   def latest_price_for_position(position)
#     latest_price_for_stock(position.stock)
#   end


# end


# def find_stock_price(stock)
#   # stock_api_service = StockApiService.new
#   content = time_series_daily(stock)
#   stock_price = stock_api_service.latest_price(stock)
# end




# binding.pry
# #amazon_price = stock_api_service.latest_price("AMZN")
# puts "eof"