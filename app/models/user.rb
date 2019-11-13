class User < ActiveRecord::Base
  has_one :portfolio
  has_many :positions, through: :portfolio

  def self.create_user(first_name, last_name, email, password)
    User.create(
      first_name: first_name,
      last_name: last_name,
      account_balance: nil,
      email: email,
      password: password
    )
  end 

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.find_by_email(email)
    User.find_by(email: email)
  end
  
  def buy_stock(stock, price)
    position = Position.find_or_create_by(portfolio_id: portfolio.id, 
      stock_id: stock.id, quantity: 1)
    position.quantity += 1
    position.save
    puts "Buy one share of #{stock.symbol} stock for $#{'%.2f' % price}\n We will take $#{'%.2f' % price} USD off your account"
  end

  def update_amount(price)
    #return amount = price
    #account_balance -= price
  end

  def increase_amount
    #
  end

  
end
