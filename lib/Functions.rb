module Functions
    def Functions.menu_generator(array)
        array.each_with_index do |value, index|
          puts "#{index +1} #{value}"    
        end
    end

    def self.pull_data(initial_currency, end_currency)
        rate = Forex.extract_rate(initial_currency,end_currency)
    end

    # arr = [["USD",3],["cad",2]]
    def self.pull_data(initial_currency, user_options)
        result = []
        row1 = []

        user_options.each do |option|
            rate = Forex.extract_rate(initial_currency,option)
            row1.push(option,rate)
            result.push(row1)
            row1=[]
        end

        return result
    end

    def self.show_table array
        rows = array
        table = Terminal::Table.new :rows => rows
        table = Terminal::Table.new :headings => ['CURRENCY', 'EXCHANGE'], :rows => rows    
          puts table
    end

    # @currency_hash=currency_hash
    # the format of this hash is {"AUD":1000, "CAD":4000}
    def self.add_currency currency_hash
        system("clear")
          puts "Please enter the currency code you want to buy:"
        code = gets.strip.to_sym
          puts "Please enter the ammount you want to buy:"
        amount = gets.strip.to_f
        initial_balance = currency_hash[code]
        
        currency_hash[code] = initial_balance  + amount
        
          puts "You purchased #{code} #{amount}"
        gets
        return currency_hash
    end

    def self.add_to_hash currency_hash, code , amount
        return currency_hash
    end



    def self.check_balance currency_hash
        system("clear")
          puts "BALANCE:"
          puts
          puts "You have the following currencies:"
        currency_hash.each do |key, amount|
            puts "#{key} : #{"%.2f"%amount}"
        end
        gets
    end

    def self.display_currency_options
          puts """
        Top Used Currencies:

        AUD Australian Dollar
        NZD New Zealand Dollar
        USD United States Dollar
        GBP British PoundSterling
        EUR Euro
        HKD Hong Kong Dollar
        SGD Singapore Dollar
        CNY Chinese Yuan Renminbi
        JPY Japanese Yen
        GTQ Guatemala Quetzal
        
        Didn't see your currency ?
        Please note you can use any currency once you follow ISO 4217 Currency Code. 
        """
    end

    def self.compare_rates 
        initial_currency="AUD"
        
        system("clear")
          puts "Default Currency: #{initial_currency}"
        user_options = []
        self.display_currency_options

          puts
        
          puts "Please choose up to three currencies."
          puts "To enter a currency please enter the code and press enter."
          puts "Please note currency code must in UPPERCASE"
          puts "To continue please type N and press enter."  

          puts
        input = ""
        while input!="N" && user_options.length<3 # just limiting the number of currencies
            print "Currency: "
            input = gets.strip
            if input!="N" && user_options.length<3 
                puts "You selected #{input}"
                user_options.push(input)
                puts
            end
        end
        system("clear")
          puts "You have chosen below currencies:"
          puts
        user_options.each do |value|
            puts value
        end
          puts "Continue? Y / N "
        
        user_input = STDIN.getch
        if user_input == 'y' || user_input=='Y'
            system("clear")
            puts
            puts "Default Currency: #{initial_currency}"
            puts "Conversion Rates:"
  
            currency_data = Functions.pull_data(initial_currency, user_options)
            Functions.show_table (currency_data)
            gets
        elsif user_input == 'n' || user_input=='N'
              puts "Selection deleted"                   
            user_options.clear     
        else 
              puts "Please press Y or N"
        end
    end
end

