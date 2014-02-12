module RuntimeUtils

	CARD_CREATION_INFO = [:name, :number, :limit]

	CARD_TRANSACTION_INFO = [:name, :amount]

	# The driver method for parsing information correctly.
	# First we split the info on white space.
	# Then we check to see if the amoung of info is too big or
	# Too small (an invalid input) and we return if it is.
	# We then associate the correct keys(our constants above)
	# with the correct command line info that was passed in
	# Finally, we either return an error message if the info
	# Is invalid, or the valid formatted info which will be used
	# To initialize or charge/credit a card

	def parse(command_line_info)
		info = command_line_info.split(" ")
		return command_line_info if too_big_or_small(info)
		formatted_info = format_info(info)
		check_validity(formatted_info)
	end

	# We get rid of the first unnecessary part of the user's prompt - i.e
	# 'add' or 'credit'/ 'charge' - and capitalize their name.
	# We then create a new hash to store the formatted information and 
	# We use the CARD_CREATION_INFO constant to create newly formatted
	# Card creation if the user prompt started with add.
	# If the user's prompt started with credit/charge, we instead use the
	# CARD_TRANSACTION_INFO constant to create the properly formatted 
	# transaction information.
	def format_info(split_info)
		parsed_info = shift_and_capitalize(split_info)
		formatted_hash = Hash.new
		if check_length(parsed_info)
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

	# The limit/ amount (the last element of the hash) of the credit/charge need to be in
	# the correct format - i.e. $1000 - otherwise we return an error.
	# If info being passed in is for creating a new card, we then check to see that the 
	# card number is an actual number, otherwise we return an error message. Finally, 
	# if everything is kosher, we return the correctly formatted info
	def check_validity(formatted_info)
		unless is_limit_valid?(formatted_info.values.last) 
			return "Limits and charge ammounts must start with a '$' sign and be followed by a valid number"
		end
		if check_length(formatted_info)
			if formatted_info[:number].to_i == 0
				return "That is not a valid number"
			end
		end
		formatted_info
	end

	# the first character of the limit needs to be a $, the rest needs to be a non 0 number
	# and the number cannot begin with 0 such as 022323
	def is_limit_valid?(limit)
		limit[0] == '$' && limit[1..-1].to_i != 0 && limit[1].to_i != 0 
	end

	# first we remove the unnecessary first element - i.e. 'add' or 'credit'
	# Then we capitalize the user's name which will be inportant later
	# Because we will always check to see if a user with a capitalized 
	# name exists before creating a new user
	def shift_and_capitalize(parsed_info)
		parsed_info.shift 
		parsed_info.first.capitalize! 
		parsed_info
	end

	def check_length(parsed_info)
		parsed_info.length == 3
	end

	# once we split up the information, if its split length is greater than 4 or less than 3
	# the user prompt that was passed in is invalid
	def too_big_or_small(info)
		info.length > 4 || info.length < 3
	end

end