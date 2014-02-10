

class ApplicationUserInterface

	# this module contains all the raw messages to be displayed by the run method
	include Messages

	# this module contains all the helper methods, such as parse, for the run method
	include RuntimeUtils

	# Attr readers so that we can do Rspec tests/ pass session_information messages
	attr_reader :credit_card, :session_information

	def initialize(credit_card)
		@session_information = Array.new
		@credit_card = credit_card
		raise ArgumentError.new("Must be initialized with a credit card class") unless @credit_card.is_a?(Class)
	end

	#need to deal with exceptions that are going to be raised
	def run 
		display_valid_commands
		command = command_prompt
		until command.downcase == "done"
			if command.downcase == "help"
				display_valid_commands
			elsif command[0..2].downcase == "add"
				create_new_card(parse(command))
			elsif command[0..5].downcase == "credit"
				credit_a_card(parse(command))
			elsif command[0..5].downcase == "charge"
				charge_a_card(parse(command))
			else 
				display_error_message
			end
			break if finished # I had to do this for rspec testing
		command = command_prompt
		end
		display_session_summary
	end


	private

	def already_exists(user)
		self.session_information.fetch(user, nil)
		# If the user already exists then we need to present them with a list of 
	end

	def create_new_card(card_information)
		self.session_information << self.credit_card.new(card_information)
	end

	def display_session_summary
		puts session_summary_message(self.session_information)
	end

	def display_error_message(command)
		puts error_message(command)
	end

	def display_valid_commands
		puts welcome_message
	end

	#See my readme for an explination
	def finished
	end

	def command_prompt
		print ">"
		gets.chomp
	end

end