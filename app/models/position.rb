class Position < ActiveRecord::Base
  belongs_to :stock
  belongs_to :portfolio

  def quantity_count
    self.count
  end

end