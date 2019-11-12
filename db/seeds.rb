#seed data

# Test stocks

Stock.find_or_create_by(company_name: "Apple", symbol: "AAPL")
Stock.find_or_create_by(company_name: "Microsoft", symbol: "MSFT")
Stock.find_or_create_by(company_name: "Google", symbol: "GOOG")
Stock.find_or_create_by(company_name: "Amazon", symbol: "AMZN")
Stock.find_or_create_by(company_name: "Tesla", symbol: "TSLA")

# Test user

user = User.find_or_create_by(
  first_name: "Tester",
  last_name: "Testing",
  email: "test@test.com",
  password: "topsecret"
)

p 'seeds done'
