class Stock < ActiveRecord::Base
  has_many :positions

  def price
    StockApiService.new.latest_price_for_stock(self)
  end
end