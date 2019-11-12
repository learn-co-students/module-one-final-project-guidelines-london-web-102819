class User < ActiveRecord::Base
  has_one :portfolio
  has_many :positions, through: :portfolio

  def self.create_user(first_name, last_name, email, password)
    User.create(first_name: first_name, last_name: last_name, account_balance: nil, email: email, password: password)
  end 

  def self.find_email(email)
    User.find_by(email: email)
  end

  def self.find_password(password)
    User.find_by(password: password)
  end

end