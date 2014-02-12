# This is the welcome message from the display_valid_commands method in the
# application_user_interface.rb. I will be using this in the application_user_interface_spec
# to ensure the message being displayed does not accidentally get changed somehow.

WELCOME_MESSAGE = <<-String

		 Welcome to Braintree Jr.

		 You can choose from the following commands:
		
		 To create a new credit card use the following format: Add Tom 4111111111111111 $1000
		 To charge an existing credit card use the following format: Charge Tom $500
		 To credit an existing credit card use the following format: Credit Tom $500
		
		 When you are ready to see a summary of all inputs type 'done'
		 To display these commands again, type 'help'

     String


def set_error_message(command)
		<<-String
		Sorry, but that is not a valid prompt: '#{command}'

		Please enter a valid command or type HELP to see a list of command options.

		String

	end