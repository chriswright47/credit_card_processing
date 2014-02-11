module RuntimeUtils

CARD_CREATION_INFO = [:name, :number, :limit]

CARD_TRANSACTION_INFO = [:name, :amount]

	def parse(command_line_info)
		info = command_line_info.split(" ")
		return command_line_info if command_line_info.length > 4 # Return immediately if the command was invalid
		info.shift
		info = format_info(info)
	end

	def format_info(information)
		formatted_hash = Hash.new
		if information.length == 3

		else

	end
	end

end