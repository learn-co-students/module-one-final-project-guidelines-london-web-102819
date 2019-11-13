require 'open-uri'   
require 'json' 
require 'pry'

class CLI
    def initialize
        @prompt = TTY::Prompt.new
        # Inject the API key into the stock service.
        @price_service = StockPriceService.new("09KS2T8J28FSB9QP")
    end

    def greet
        input = @prompt.select(
            "Welcome to MyStockExchange! Please select and option from the menu",
            ["Sign Up", "Login", "Delete Account", "Exit"]
        )
        if input == "Sign Up"
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
        # https://regex101.com/r/ARXVie/1
        if /.+@.+\..+/.match(@email)
            account_registered?
        else 
            puts "Looks like your email format is incorrect. Please try again"
            email_getter
        end
    end

    def account_registered?
        user = User.find_by_email(@email)
        if user != nil && @email == user.email
            input = @prompt.select(
                "Looks like you are already registered with us. Would you like to login?",
                ["Login", "Exit"]
            )
            if input == "Login"
                login_greet
            elsif input == "Exit"
                return
            end
        else
            password_getter
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
            password_confirm = @prompt.mask("Please confirm your password:")
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
        dashboard
    end

    def login_greet
        puts "Email:"
        email = gets.chomp
        @user = User.find_by_email(email)
        password = @prompt.mask("Password:")
        @user_password = @user.password
        verify
    end

    def verify
        if @user && @user_password == @user.password
            successful_login
        else
            login_fail
        end
    end

    def successful_login
        puts "You have sucessfuly logged in #{@user.first_name}!"
        dashboard
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
        @user = User.find_by_email(user_email)
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

    def dashboard
        input = @prompt.select(
            "Dashboard:",
            ["View Current Stocks", "View Stock Market", "Logout", "Exit"]
        )

        if input == "View Current Stocks"
            view_current_stocks
        elsif input == "View Stock Market"
            # read fucntion
        elsif input == "Logout"
            greet
        else 
            return      
        end

    end

    def view_current_stocks
        stocks = Stock.all
        puts "Stocks in the system:"
        stocks.each_with_index do |stock, i|
            puts "#{i}. #{stock.symbol} #{stock.company_name}"
        end
        input = @prompt.select(
            "Which stock are you interested in?",
            stocks.map { |stock| stock.symbol }
        )
        view_single_stock(input)
    end

    def view_single_stock(symbol)
        stock = Stock.find_by(symbol: symbol)
        price = @price_service.latest_price_for_stock(stock)
        puts ""
        puts "The latest price for #{stock.company_name} is $#{'%.2f' % price}USD"
        puts ""
        input = @prompt.select(
            "What would you like to do?",
            [
                "Buy #{stock.company_name}",
                "Sell #{stock.company_name}",
                "Dashboard"
            ]
        )
        if input == "Buy #{stock.company_name}"
            @user.buy_stock(stock, price)
        elsif input == "Sell #{stock.company_name}"
            sell_stock(stock, price)
            puts "We will implement selling a stock"
        end
        dashboard
    end

    
end
