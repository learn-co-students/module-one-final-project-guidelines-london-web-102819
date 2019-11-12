#seed data

# Test stocks

apple = Stock.find_or_create_by(company_name: "Apple", symbol: "AAPL")
microsoft = Stock.find_or_create_by(company_name: "Microsoft", symbol: "MSFT")
google = Stock.find_or_create_by(company_name: "Google", symbol: "GOOG")
amazon = Stock.find_or_create_by(company_name: "Amazon", symbol: "AMZN")
tesla = Stock.find_or_create_by(company_name: "Tesla", symbol: "TSLA")


# Test user

user1 = User.find_or_create_by(
  first_name: "Qing",
  last_name: "Wang",
  email: "qing@gmail.com",
  password: "mypassword"
)

user2 = User.find_or_create_by(
  first_name: "Faris",
  last_name: "Aziz",
  email: "faris@gmail.com",
  password: "12345678"
)

user3 = User.find_or_create_by(
  first_name: "Andy",
  last_name: "Lewell",
  email: "andy@gmail.com",
  password: "topsecrect"
)

# Test portfolio

portfolio1 = Portfolio.find_or_create_by( user_id: user1.id)
portfolio2 = Portfolio.find_or_create_by( user_id: user2.id)
portfolio3 = Portfolio.find_or_create_by( user_id: user3.id)


# Test position

position1 = Position.find_or_create_by(
  portfolio_id: portfolio1,
  stock_id: apple,
  quantity: 80
)

position2 = Position.find_or_create_by(
  portfolio_id: portfolio2,
  stock_id: microsoft,
  quantity: 15
)
position3 = Position.find_or_create_by(
  portfolio_id: portfolio3,
  stock_id: google,
  quantity: 223
)

p 'seeds done'
