require 'open-uri'   
require 'json' 
require 'pry'

class CLI
    def initialize
        @prompt = TTY::Prompt.new
    end

    # @api_key = "09KS2T8J28FSB9QP"
    # @stock = ["AAPL", "MSFT", "AMZN", "SNAP", "GOOG", "YHOO", "TSLA", "NIKE"].sample
  def time_series_daily(symbol)
    content = open("https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=#{symbol}&apikey=09KS2T8J28FSB9QP").read
    JSON.parse(content)
  end


    def greet
        input = @prompt.select("Welcome to MyStockExchange! Please select and option from the menu", ["Sign Up", "Login", "Delete Account", "Exit"])
       
        if  input == "Sign Up"
            register
        elsif input == "Login"
            login_greet
        elsif input == "Delete Account"
            delete_user
        else
            return    
        end
    end

    def register
        puts 'Full Name:'
        name = gets.chomp
        full_name = name.split
        first_name = full_name[0]
        last_name = full_name[1]
        @first_name = first_name
        @last_name = last_name
        email_getter
    end

    def email_getter
        puts 'Email:'
        @email = gets.chomp
        email_format_checker
    end


    def email_format_checker
        if @email.include?("@")
            account_registered?
        else 
            puts "Looks like your email format is incorrect. Please try again"
            email_getter
        end
    end

    def account_registered?
        user = User.find_email(@email)
        if @email == user.email
            input = @prompt.select("Looks like you are already registred with us. Would you like to login?", ["Login","Exit"])
            if input == "Login"
                login_greet
            elsif input == "Exit"
                return
            else
                password_getter
            end
        end
    end

    def password_getter
            @password = @prompt.mask("Password (Minimum 8 characters):")
            password_checker
    end

    def password_checker
        if @password.length < 8
            puts "Sorry, looks like your password isn't strong enough"
            input = @prompt.select(" ", ["Try again", "Exit"])
                if input == "Try again"
                    password_getter
                else
                    return 
                end
        else
            password_confirm = @prompt.mask("Please confirm your password")
            if @password == password_confirm
                successful_register 
            else
                puts "Looks like your password confirmation doesn't match"
                input = @prompt.select(" ", ["Try again", "Exit"])
                if input == "Try again"
                    password_getter
                else
                    return 
                end
            end
        end
    end

    def successful_register 
        @user = User.create_user(@first_name, @last_name, @email, @password) 
        puts "You have sucessfuly registered #{@user.first_name}!"
        dasboard
    end

    def login_greet
        puts "Email:"
        email = gets.chomp
        @user = User.find_email(email)
        password = @prompt.mask("Password:")
        @user_password = User.find_password(password)
        verify
    end 

    def verify
        if @user && @user_password != nil
            successful_login
        else
            login_fail
        end
    end

    def successful_login
        puts "You have sucessfuly logged in #{@user.first_name}!"
        dasboard
    end

    def login_fail
        puts "Oops! looks like you put in the wrong email/password or are not registered with us."
        puts "Please try again or sign up"
        greet
    end

    def delete_user
        verify_delete
        input = @prompt.select("Are you sure you would like to delete your account?", ["Yes", "No"])

        if input == "Yes"
            @user.destroy
            greet
        else
            greet
        end
    end 

    def verify_delete
        puts "Please provide your registered email:"
        user_email = gets.chomp
        @user = User.find_email(user_email)
        if  @user != nil
            puts "Account holder: #{@user.first_name}"
        else
            check_fail
        end
    end

    def check_fail
        input = @prompt.select("Sorry, doesn't look like that email is registered with us. Would you like to try again or exit?", ["Try Again", "Exit"])
        if input == "Try Again"
            delete_user
        else
            greet
        end
    end

    def view_stock_market
        time_series = time_series_daily(symbol)["Time Series (Daily)"]
        latest_data = time_series.first
        close_price = latest_data[1]["4. close"].to_f.round(2)
    end 


    def dasboard
        input = @prompt.select("Dashboard:", ["View Current Stocks", "View Stock Market", "Logout" "Exit"])

        if input == "View Current Stocks"
            # read function
        elsif input == "View Stock Market"
            # read fucntion
        elsif input == "Logout"
            greet
        else 
            return      
        end

    end


end

# def latest_price(symbol)
#     time_series = time_series_daily(symbol)["Time Series (Daily)"]
#     latest_data = time_series.first
#     close_price = latest_data[1]["4. close"].to_f.round(2)
#   end