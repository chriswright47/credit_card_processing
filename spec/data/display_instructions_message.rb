# This is the welcome message from the display_valid_commands method in the
# application_user_interface.rb. I will be using this in the application_user_interface_spec
# to ensure the message being displayed does not accidentally get changed somehow.

WELCOME_MESSAGE = <<-String
		 Welcome to Braintree Jr.

		 You can choose from the following commands:
		
		 To add a new credit card use the following format: Add Tom 4111111111111111 $1000
		 To charge a credit card use the following format: Charge Tom $500
		 To credit a credit card use the following format: Credit Tom $500
		
		 When you are ready to see a summary of all inputs type DONE
		 To display these commands again, type HELP
     To exit, type EXIT
     String