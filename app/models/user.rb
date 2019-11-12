class User < ActiveRecord::Base
  has_one :portfolio
  has_many :positions, through: :portfolio

  def self.create_account
  end
  
end