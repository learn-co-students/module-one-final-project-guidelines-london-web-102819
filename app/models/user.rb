class User < ActiveRecord::Base
  has_one :portfolio
  has_many :positions, through: :portfolio

  def self.create_user(first_name, last_name, account_balance, email, password)
    User.create(
      first_name: first_name,
      last_name: last_name,
      account_balance: account_balance,
      email: email,
      password: password
    )
  end 

  def create_portfolio
    portfolio = Portfolio.find_or_create_by(user_id: self.id)
    portfolio.save
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def self.find_by_email(email)
    User.find_by(email: email)
  end

  def buy_stock(stock, price)
    portfolio = Portfolio.find_or_create_by(user_id: self.id)
    position = Position.find_or_create_by(
      portfolio_id: portfolio.id, 
      stock_id: stock.id
    )
    position.quantity += 1
    position.save
  end

    def position_exist?(stock)
        Position.find_by(stock_id: stock.id)
    end

    def position_quantity_valid?(input_quantity, stock)
        stock_quanity = Position.find_by(stock_id: stock.id).quantity
        stock_quanity >= input_quantity
    end

    def sell_stock(stock, price, input_quantity)
        position = Position.find_or_create_by(
          portfolio_id: portfolio.id, 
          stock_id: stock.id
        )
        position.quantity -= input_quantity
        position.save
        total = price * input_quantity
        self.deposit(total)
    end

  def deposit(money_in)
    if money_in == nil
      money_in = 0
   end
   if self.account_balance == nil
      self.account_balance = 0
   end
   self.account_balance += money_in
   self.save  
  end

  def account_valid?(money_out)
    money_out <= self.account_balance
  end

  def withdraw(money_out)
    self.account_balance -= money_out
    self.save  
  end

  def get_balance
    self.account_balance
  end

  def fmt_balance
    '%.2f' % self.account_balance
  end

end
