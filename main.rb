require 'terminal-table'
require 'alphavantagerb'
require 'io/console' # this module allow us to read user input char by char. 
require_relative 'lib/Functions' 
require_relative 'lib/Forex'
require_relative 'lib/Menus'

currency_hash = {"AUD":10000, "USD":0}


Menus.main_menu(currency_hash)

