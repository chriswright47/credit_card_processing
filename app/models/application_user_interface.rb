class ApplicationUserInterface

	include Messages

	# We have a reader for credit_card so that we can do Rspec tests
	attr_reader :credit_card

	def initialize(credit_card)
		@credit_card = credit_card
		raise ArgumentError.new("Must be initialized with a credit card class") unless @credit_card.is_a?(Class)
	end

	def run #need to deal with exceptions that are going to be raised
		display_valid_commands
		command = command_prompt

		puts

		until command == "EXIT"
			if command == "HELP"
				display_valid_commands
			elsif command == ""
				
			end

		end
	end

	private

	def display_valid_commands
		puts welcome_message
	end

	def command_prompt
		print ">"
		gets.chomp
	end

end