require_relative 'Functions'

module Menus

    def self.main_menu currency_hash
        system("clear")
        user_input = '' #just creating the var
        while true
            system("clear")     
            array = ["Buy Currency","Convert Currency","Check Balance","Compare Rates","About"]
            Functions.menu_generator(array)
              puts
              puts "Press Q to quit"    
            user_input = STDIN.getch #this method read user input char by char
            case user_input
            when '1'        
                currency_hash = Functions.add_currency (currency_hash)
            when '2'
                self.forex(currency_hash)
            when '3'
                Functions.check_balance(currency_hash)
            when '4'
                Functions.compare_rates

            when '5'
                self.about_display

            when 'q' 
                system("clear")
                exit    # exit command kills the program in the console. 
            when 'Q'
                system("clear")
                exit    # exit command kills the program in the console. 
            end
        end 
    end

    def self.about_display
        system("clear")
          puts 
          puts 

          puts"""
            Terminal FOREX is a simple app that demonstrate the currency exchange transaction using API tool courtesy of AlphaVantage. 
            
            Terminal FOREX was created by Diego Rodriguez & Thomas Lawrence.

            Please check README.md for more information. 

            



            Press Enter to return to main menu. 
        """
        gets 
    
    end


    def self.forex(currency_hash)
        user_input = ''

        system("clear")
          puts "Foreign Currency Exchange"
          puts ""
        # aud_usd = self.extract_rate ("USD")
          puts "Your current balance is:"
        currency_hash.each do |key, amount|
            puts "#{key} : #{amount}"
        end
          puts " "
        Functions.display_currency_options

          puts "Please enter the currency you want to trade with:"
        origin_code = gets.strip.to_sym
          puts "Please enter the currency you want to purchase:"
        end_code = gets.strip.to_sym
          puts "Please enter the amount you want to purchase in #{origin_code}:"
        amount= gets.strip.to_f
          puts "Retrieving information....."
        rate = Forex.extract_rate(origin_code,end_code)
          puts 
        system("clear")
          puts "The conversion rate from #{origin_code} to #{end_code} is: #{rate}"
        converted_amount = rate.to_f*amount
          puts
          puts "#{origin_code} #{"%.2f"%amount} will get you #{end_code} #{"%.2f"%converted_amount}"
          puts
          puts "Press Y to perfom transaction or any other key to cancel transaction." 
        user_input = STDIN.getch
        if user_input == 'y' || user_input=='Y'
            currency_exist =false
            currency_hash.each do |key,value|
                if key==end_code
                    currency_exist=true
                end
            end

            if currency_exist==false
                currency_hash[end_code] = 0
            end
            
            currency_hash.each do |key, value|
                if key==origin_code
                    currency_hash[key]=  value - amount
                end     
            end    

            currency_hash.each do |key, value|
                if key==end_code
                    currency_hash[key]=  value + converted_amount
                end     
            end  
            
            puts    
            puts "You successfully purchased #{end_code} #{"%.2f"%converted_amount}"
        else 
            puts
            puts "Transaction Cancelled."
        end

        gets
    end
end