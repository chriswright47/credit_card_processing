module RuntimeUtils

	CARD_CREATION_INFO = [:name, :number, :limit]

	CARD_TRANSACTION_INFO = [:name, :amount]

	def parse(command_line_info)
		info = command_line_info.split(" ")
		return command_line_info if info.length > 4 || info.length < 3 # Return immediately if the command was invalid
		formatted_info = format_info(info) # associate the correct keys with the command_line_info
		check_validity(formatted_info)
	end

	def format_info(split_info)
		parsed_info = shift_and_capitalize(split_info)
		formatted_hash = Hash.new
		if parsed_info.length == 3 # that is, if command_prompt started with'add'
			CARD_CREATION_INFO.each do |element|
				formatted_hash[element] = parsed_info.shift
			end
		else
			CARD_TRANSACTION_INFO.each do |element| # if the command prompt started with 'credit' or 'charge'
				formatted_hash[element] = parsed_info.shift
			end
		end
		formatted_hash #appropriately formatted hash
	end

	def check_validity(formatted_info)
		unless is_limit_valid?(formatted_info.values.last) # both limit and amount need to be in the correct format
			return "Limits and charge ammounts must start with a '$' sign and be followed by a valid number"
		end
		if formatted_info.length == 3 #the card number needs to be an actual number
			return "That is not a valid number" if formatted_info[:number].to_i == 0
		end
		formatted_info # if everything is kosher we return the correctly formatted info
	end

	def is_limit_valid?(limit)
		limit[0] == '$' && limit[1..-1].to_i != 0 && limit[1].to_i != 0 # the first character of the limit needs to be a $, the rest needs to be a non 0 number
	end

	def shift_and_capitalize(parsed_info)
		parsed_info.shift #remove unnecessary first element - i.e. 'add' or 'credit'
		parsed_info.first.capitalize! # Important name formatting so we dont have duplicate users
		parsed_info
	end
end