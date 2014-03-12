# As the name implies, this module contains various methods which help
# parse and format user inputs during the run time of the application.
# The methods can also be used by different classes for things like 
# checking to see if credit card limits/charges are valid

module RuntimeUtils

	CARD_CREATION_INFO = [:name, :number, :limit]

	CARD_TRANSACTION_INFO = [:name, :amount]


	def parse(command_line_info)
		info = command_line_info.split(" ")
		return command_line_info if too_big_or_small?(info)
		formatted_info = format_info(info)
		check_validity(formatted_info)
	end


	def format_info(split_info)
		parsed_info = shift_and_capitalize(split_info)
		formatted_hash = Hash.new
		if is_this_add_card_info?(parsed_info)
			CARD_CREATION_INFO.each do |element|
				formatted_hash[element] = parsed_info.shift
			end
		else
			CARD_TRANSACTION_INFO.each do |element|
				formatted_hash[element] = parsed_info.shift
			end
		end
		formatted_hash 
	end


	def check_validity(formatted_info)
		unless is_limit_valid?(formatted_info.values.last) 
			return "Limits and charge ammounts must start with a '$' sign and be followed by a valid whole number."
		end
		if is_this_add_card_info?(formatted_info)
			if invalid_number?(formatted_info[:number])
				return "That is not a valid number or it is more than 19 digits"
			end
		end
		formatted_info
	end


	def invalid_number?(number)
		number.length != number.to_i.to_s.length || number.length > 19
	end


	def is_limit_valid?(limit)
		limit[0] == '$' && !invalid_number?(limit[1..-1]) && limit[1].to_i != 0
	end


	def shift_and_capitalize(parsed_info)
		parsed_info.shift 
		parsed_info.first.capitalize! 
		parsed_info
	end


	def too_big_or_small?(info)
		info.length > 4 || info.length < 3
	end


	def is_this_add_card_info?(parsed_info)
		parsed_info.length == 3
	end

end