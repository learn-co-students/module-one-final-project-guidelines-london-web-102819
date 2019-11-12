require 'open-uri'   
require 'json' 
require 'pry'

class StockPriceService
  # Use a cache so we only have to fetch the price once per process.
  @@price_cache = {}

  def initialize(api_key = "09KS2T8J28FSB9QP")
    @api_key = api_key
  end

  def time_series_daily(symbol)
    content = open("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=#{@api_key}").read
    JSON.parse(content)
  end

  # Get the latest price for a given symbol, e.g. MSFT or AMZN
  def latest_price_for_symbol(symbol)
    if !@@price_cache.include?(symbol) 
      time_series = time_series_daily(symbol)["Time Series (Daily)"] #the whole hash
      recent_day, recent_day_data = time_series.first  #get the first key pair of the hash
      close_price = recent_day_data["4. close"] #get the value of the key named "4. close"
      @@price_cache[symbol] = close_price.to_f
    end
    @@price_cache[symbol]
  end

  def latest_price_for_stock(stock)
    latest_price_for_symbol(stock.symbol)
  end

  def latest_price_for_position(position)
    latest_price_for_stock(position.stock)
  end

end
