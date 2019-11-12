#seed data

Stock.create(price: Faker::Number.number(digits: 3), company_name: "Apple")
Stock.create(price: Faker::Number.number(digits: 2), company_name: "Microsoft")
Stock.create(price: Faker::Number.number(digits: 4), company_name: "Google")
Stock.create(price: Faker::Number.number(digits: 3), company_name: "Amazon")
Stock.create(price: Faker::Number.number(digits: 3), company_name: "Tesla")
Stock.create(price: Faker::Number.number(digits: 1), company_name: "GoPro")
Stock.create(price: Faker::Number.number(digits: 2), company_name: "Nike")
Stock.create(price: Faker::Number.number(digits: 2), company_name: "EROS")
Stock.create(price: Faker::Number.number(digits: 2), company_name: "Snap")
Stock.create(price: Faker::Number.number(digits: 4), company_name: "Boeing")
Stock.create(price: Faker::Number.number(digits: 2), company_name: "Yahoo")
Stock.create(price: Faker::Number.number(digits: 3), company_name: "Facebook")
Stock.create(price: Faker::Number.number(digits: 1), company_name: "Blackberry")
Stock.create(price: Faker::Number.number(digits: 2), company_name: "Alibaba")
Stock.create(price: Faker::Number.number(digits: 2), company_name: "Adobe")
Stock.create(price: Faker::Number.number(digits: 3), company_name: "21st Century Fox")


p 'seeds done'  