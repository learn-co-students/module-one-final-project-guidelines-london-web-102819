class Portfolio < ActiveRecord::Base
  has_many :positions
  belongs_to :user

  def total_value
    
  end
  
end