class Portfolio < ActiveRecord::Base
  has_many :positions
  belongs_to :user

  def total_value
    self.positions.map { |p| p.stock.price }.sum
  end
  
end