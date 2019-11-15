#seed data

# Test stocks

apple = Stock.find_or_create_by(company_name: "Apple", symbol: "AAPL")
microsoft = Stock.find_or_create_by(company_name: "Microsoft", symbol: "MSFT")
google = Stock.find_or_create_by(company_name: "Google", symbol: "GOOG")
amazon = Stock.find_or_create_by(company_name: "Amazon", symbol: "AMZN")
tesla = Stock.find_or_create_by(company_name: "Tesla", symbol: "TSLA")
alibaba = Stock.find_or_create_by(company_name: "Alibaba", symbol: "BABA")

# Test user
user1 = User.find_or_create_by(
  first_name: "Qing",
  last_name: "Wang",
  account_balance: 100000,
  email: "qing@gmail.com",
  password: "password"
)

user2 = User.find_or_create_by(
  first_name: "Faris",
  last_name: "Aziz",
  account_balance: 100000,
  email: "faris@gmail.com",
  password: "123456"
)

user3 = User.find_or_create_by(
  first_name: "Andy",
  last_name: "Lewell",
  account_balance: 100000,
  email: "andy@gmail.com",
  password: "topsecrect"
)

# Test portfolio

portfolio1 = Portfolio.find_or_create_by( user_id: user1.id)
portfolio2 = Portfolio.find_or_create_by( user_id: user2.id)
portfolio3 = Portfolio.find_or_create_by( user_id: user3.id)


# Test position
position1 = Position.find_or_create_by(
  portfolio_id: portfolio1.id,
  stock_id: apple.id,
  quantity: 10
)

position2 = Position.find_or_create_by(
  portfolio_id: portfolio2.id,
  stock_id: microsoft.id,
  quantity: 15
)

p 'seeds done'
