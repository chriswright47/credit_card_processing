# If we ever have any other large messages to display to the user we can put them in this module

module Messages

	def welcome_message
		<<-String

		 Welcome to Braintree Jr.

		 You can choose from the following commands:

		 To create a new credit card use the following format: Add Tom 4111111111111111 $1000
		 To charge an existing credit card use the following format: Charge Tom $500
		 To credit an existing credit card use the following format: Credit Tom $500

		 When you are ready to see a summary of all inputs type 'done'
		 To display these commands again, type 'help'

     String
	end

	def error_message(command)
		<<-String
		Sorry, but that is not a valid prompt: '#{command}'

		Please enter a valid command or type HELP to see a list of command options.

		String

	end

	def session_summary_message(session_hash)
		tmp_array =[]
		session_hash.each do |element|
			tmp_array << "#{element.name}: $#{element.balance}\n"
		end
		tmp_array
	end

	def invalid_user_message(user_name)
		"User #{user_name} does not exist. You must create a card for them first\n"
	end

	def user_already_exists_message(user_name)
		"Sorry, but a user with the name of '#{user_name}' already exists. For now all users must have unique names\n"
	end
end