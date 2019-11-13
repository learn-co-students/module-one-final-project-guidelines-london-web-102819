class Stock < ActiveRecord::Base
  has_many :positions

  def price
    StockPriceService.new.latest_price_for_stock(self)
  end
end