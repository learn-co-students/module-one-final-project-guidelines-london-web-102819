class User < ActiveRecord::Base 



    def self.create_user(first_name, last_name, email, password)
        User.create(first_name: first_name, last_name: last_name, email: email, password: password)
    end 
end