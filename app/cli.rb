class CLI
    def initialize
        @prompt = TTY::Prompt.new
    end

    def greet
        input = @prompt.select("Welcome to MyStockExchange! Please select and option from the menu", ["Sign Up", "Login", "Delete Account", "Exit"])
       
        if  input == "Sign Up"
             register
        elsif input == "Login"
            # login_greet
        elsif input == "Delete Account"
            # delete_athlete
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

            puts 'Email:'
            @email = gets.chomp

            password_getter
            
            

            @user = User.create_user(@first_name, @last_name, @email, @password) 
            # successful_register

    end

    def password_getter
        puts "Password (Minimum 8 characters):"
            @password = gets.chomp
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
            puts "Please confirm your password"
            password_confirm = gets.chomp 
            if @password == password_confirm
                #method for succesful registration
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

end