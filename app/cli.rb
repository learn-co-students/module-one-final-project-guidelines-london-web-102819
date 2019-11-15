require 'open-uri'   
require 'json' 
require 'pry'
require 'progress_bar'

class CLI
    def initialize
        @prompt = TTY::Prompt.new
        @price_service = StockPriceService.new("09KS2T8J28FSB9QP")
        @bar = ProgressBar.new
    end

    def greet
        puts "                                                                           
                                                                                          
$$$$$$\   $$\                      $$\       
$$  __$$\  $$ |                     $$ |      
$$ /  \__$$$$$$\   $$$$$$\  $$$$$$$\$$ |  $$\ 
\$$$$$$\ \_$$  _| $$  __$$\$$  _____$$ | $$  |
 \____$$\  $$ |   $$ /  $$ $$ /     $$$$$$  / 
$$\   $$ | $$ |$$\$$ |  $$ $$ |     $$  _$$<  
\$$$$$$  | \$$$$  \$$$$$$  \$$$$$$$\$$ | \$$\ 
 \______/   \____/ \______/ \_______\__|  \__|
                                                       "
       
        input = @prompt.select(
            "Welcome to MyStockExchange! Please select and option from the menu",
            ["Sign Up", "Login", "Forgot Password", "Delete Account", "Exit"]
        )
        if input == "Sign Up"
            register
        elsif input == "Login"
            login_greet
        elsif input == "Delete Account"
            delete_user
        elsif input == "Forgot Password"
            forgot_password
        else
            return  
        end
    end


    def register
        puts 'Full Name:'
        @name = gets.chomp
        full_name = @name.split
        first_name = full_name[0]
        last_name = full_name[1]
        @first_name = first_name
        @last_name = last_name
        name_format_checker
    end

    def name_format_checker
        if /^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$/.match(@name)
        email_getter
        else
           puts "Opps! Looks like your name format is incorrect. Please try again."
           register
        end
    end

    def email_getter
        puts 'Email:'
        @email = gets.chomp
        email_format_checker
    end

    def email_format_checker
        if /.+@.+\..+/.match(@email)
            account_registered?
        else 
            puts "Looks like your email format is incorrect. Please try again."
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
        @password = @prompt.mask("Password (Minimum 6 characters):")
        password_checker
    end

    def password_checker
        if @password.length < 6
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
                security_question
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

    def security_question
        puts "As a security measure in case you lose you password please input your date of birth(DD/MM/YYYY):"
        @security_answer = gets.chomp
        successful_register 
    end


    def successful_register
        @user = User.create_user(@first_name, @last_name, 0.0, @email, @password, security_answer) 
        puts "You have sucessfuly registered #{@user.first_name}!"
        @user.create_portfolio
        dashboard
    end

    def login_greet
        puts "Email:"
        email = gets.chomp.downcase
        @user = User.find_by_email(email)
        @password = @prompt.mask("Password:")
        verify
    end

    def verify
        if @user != nil && @password == @user.password
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
        puts "Oops! Looks like you put in the wrong email/password or you are not registered with us."
        puts "Please try again or sign up"
        greet
    end

    def forgot_password
        puts "Please provide your registered email:"
        user_email = gets.chomp
        @user = User.find_by_email(user_email)
        if @user != nil
            puts "Please input your date of birth (DD/MM/YYYY) to verify that this is your account:"
            sec_ans = gets.chomp
            if sec_ans == @user.security_answer
                puts "Your password is *#{@user.password}*"
            end
        input = @prompt.select("Would you like to login?", ["Yes", "No"])

        if input == "Yes"
            login_greet
        else
            return
        end
    else
        input = @prompt.select("Sorry, looks like you put the wrong email in. Would you like to try again or return to menu?", ["Yes", "No"])
        if input == "Yes"
            forgot_password
        else
            greet
        end
    end

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
        @user.reload
        input = @prompt.select(
            "Dashboard:",
            ["Portfolio", "Account", "Stock Market", "Logout", "Exit"]
        )
        if input == "Stock Market"
            100.times do
                sleep 0.02
                @bar.increment!
              end
            view_current_stocks
            dashboard
        elsif input == "Account"
            puts "Your balance is $#{@user.fmt_balance}"
            account_menu
        elsif input == "Portfolio"
            portfolio_menu
            dashboard
        elsif input == "Logout"
            greet
        elsif input == "Exit"
            return
        end
    end

    def portfolio_menu
        @user.reload
        puts "Hi #{@user.first_name}, how are you today? What would you like to do?"
        input = @prompt.select(
        "Portfolio Menu:",
        ["View Statement", "Go back to the previous page"]) 
        if input == "View Statement"
            100.times do
                sleep 0.02
                @bar.increment!
              end
            handle_portfolio
        end
        dashboard 
    end


    def handle_portfolio
        @user.reload
        positions = @user.portfolio.positions
        if positions.size < 1
          puts "It looks like you don't have any stocks yet"
        end
        positions.each do |p|
            price = @price_service.latest_price_for_position(p)
            puts "
Company: #{p.stock.company_name}
- Shares: #{p.quantity}
- Price: $#{'%.2f' % price}
- Value: $#{'%.2f' % (price * p.quantity)
}
"    end
     
    end
    
    def account_menu
        puts "What would you like to do?"
        input = @prompt.select(
        "Account Menu:",
        ["Top up", "Withdraw", "Go back"])
        if input == "Top up"
           handle_top_up
        elsif input == "Withdraw"
           handle_withdraw
        elsif input == "Go back"
            dashboard
        end
    end


    def handle_top_up
        @user.reload
        puts "How much would you like to top up? input a number please!"
            deposit_amount = gets.chomp.to_f
            if deposit_amount > 0
                @user.deposit(deposit_amount)
                puts ""
                puts "You have sucessfully topped up $#{'%.2f' % deposit_amount}."
                puts "You now have $#{@user.fmt_balance} in your cash account."
                puts ""
            else
                puts "Invalid top-up amount!"
            end
            dashboard
    end

    def handle_withdraw
        @user.reload
        puts "How much would you like to withdraw? input a number please!"
        money_out = gets.chomp.to_f
        if money_out > 0 && @user.account_valid?(money_out)
           @user.withdraw(money_out)
           puts ""
           puts "You have sucessfully withdrawn #{'%.2f' % money_out}!"
           puts "Your cash account balance is $#{@user.fmt_balance} now."
           puts ""
           dashboard
        else
           puts ""
           puts "Withdraw rejected, please check your account balance"
           puts ""
           dashboard
        end
    end

    def view_current_stocks
        @user.reload
        stocks = Stock.all
        100.times do
            sleep 0.02
            @bar.increment!
          end
        puts "Stocks in the system:"
        puts ""
        tp stocks, "company_name", "symbol"
        puts ""
        input = @prompt.select(
            "Which stock are you interested in?",
            stocks.map { |stock| stock.symbol }
        )
        view_single_stock(input)
    end


    def view_single_stock(symbol)
        @user.reload
        stock = Stock.find_by(symbol: symbol)
        price = @price_service.latest_price_for_stock(stock)
        100.times do
            sleep 0.02
            @bar.increment!
          end
        puts ""
        puts "The latest price for #{stock.company_name} is $#{'%.2f' % price} USD"
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
            handle_buy_stock(price, stock)
        elsif input == "Sell #{stock.company_name}"
            handle_sell_stock(price, stock)
        end
        dashboard
    end

    def handle_buy_stock(price, stock)
        @user.reload
        if @user.account_valid?(price)
           @user.buy_stock(stock, price)
           @user.withdraw(price)
            puts ""
            puts "Bought one share of #{stock.symbol} stock for $#{'%.2f' % price}"
            puts "We have taken $#{'%.2f' % price} USD off your account."
            puts "You have $#{@user.fmt_balance} in your cash account now."
            puts ""
        dashboard
        else
            puts ""
            puts "Sorry, it looks like you don't have enough balance in your account."
            puts "You can top up from the Account menu below or go back to the dashboard."
            puts ""
            account_menu
        end
    end

    def handle_sell_stock(price, stock)
        @user.reload
        if !@user.position_exist?(stock)
           puts ""
           puts "Sorry, it looks like that you don't have that stock"
           puts ""
           input = @prompt.select("Would you like to buy some #{stock.company_name} stocks?", ["Yes", "No"])
        if input == "Yes"
            handle_buy_stock(price, stock)
        else
            dashboard
        end
         else
           puts ""
           puts "How many shares would you like to sell? input a number please!"
           quantity_input = gets.chomp.to_i 
           if quantity_input <= 0 || !@user.position_quantity_valid?(quantity_input, stock)
              puts ""
              puts "Request rejected. It looks like you don't have enough shares, please try again"
              handle_sell_stock(price, stock)
           elsif 
           total = quantity_input * price
           @user.sell_stock(stock, price, quantity_input)
            puts ""
            puts "You have sold #{quantity_input} shares of #{stock.company_name},"
            puts "the total value is $#{total}."
            puts ""
            puts "Your have $#{@user.fmt_balance} in your account now."
            puts ""
           end
           dashboard
      end
    end
    
end

