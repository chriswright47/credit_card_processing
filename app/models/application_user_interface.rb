class ApplicationUserInterface
	include Messages

	# We have a reader for credit_card so that we can do Rspec tests
	attr_reader :credit_card

	def initialize(credit_card)
		@credit_card = credit_card
		raise ArgumentError.new("Must be initialized with a credit card class") unless @credit_card.is_a?(Class)
	end

	def display_valid_commands
		welcome_message
	end

end