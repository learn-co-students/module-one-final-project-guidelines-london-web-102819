require 'open-uri'    #https://ruby-doc.org/stdlib-2.6.3/libdoc/open-uri/rdoc/OpenURI.html
require 'json' 
require 'pry'

class StockApiService
  @@price_cache = {}

  def initialize(api_key = "09KS2T8J28FSB9QP")
    @api_key = api_key
  end

  def time_series_daily(symbol = "MSFT")
    content = open("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=#{@api_key}").read
    JSON.parse(content)
    #JSON.parse() to convert text into a JavaScript object
  end

  def latest_price(symbol = "MSFT")
    if !@@price_cache.include?(symbol) 
      time_series = time_series_daily(symbol)["Time Series (Daily)"] #the whole hash
      recent_day, recent_day_data = time_series.first  #get the first key pair of the hash
      close_price = recent_day_data["4. close"] #get the value of the key named "4. close"
      @@price_cache[symbol] = close_price.to_f   
    end
    @@price_cache[symbol]
  end

  def latest_price_for_stock(stock)
    latest_price(stock.symbol)
  end

  def latest_price_for_position(position)
    latest_price_for_stock(position.stock)
  end

end

stock_api_service = StockApiService.new
#binding.pry
#amazon_price = stock_api_service.latest_price("AMZN")
puts "something"
