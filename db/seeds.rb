#seed data

# Test stocks

Stock.find_or_create_by(company_name: "Apple", symbol: "AAPL")
Stock.find_or_create_by(company_name: "Microsoft", symbol: "MSFT")
Stock.find_or_create_by(company_name: "Google", symbol: "GOOG")
Stock.find_or_create_by(company_name: "Amazon", symbol: "AMZN")
Stock.find_or_create_by(company_name: "Tesla", symbol: "TSLA")

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



p 'seeds done'
