#seed data

Stock.find_or_create_by(company_name: "Apple", symbol: "AAPL")
Stock.find_or_create_by(company_name: "Microsoft", symbol: "MSFT")
Stock.find_or_create_by(company_name: "Google", symbol: "GOOG")
Stock.find_or_create_by(company_name: "Amazon", symbol: "AMZN")
Stock.find_or_create_by(company_name: "Tesla", symbol: "TSLA")

p 'seeds done'
