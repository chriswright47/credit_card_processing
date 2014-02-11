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
	end

	def run
		session_driver
	end

	private

	def session_driver
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

	def already_exists(user)
		# If the user already exists then we need to present them with a list of 
		self.session_information.fetch(user, nil)
	end

	def create_new_card(card_information)
		#this would be an invalid command with too many words
		return display_error_message(card_information) unless card_information.length == 3 
		#check to see if user already exists
		self.session_information << self.credit_card.new(card_information)
	end

	def fetch_a_card(card_owner)
		self.session_information.each do |element|
			return element if element.name == card_owner
		end
	end

	def credit_a_card(params)
		card = fetch_a_card(params.fetch(:name,nil))
		if card == nil
			puts "User with that name was not found"
			return
		end
		card.credit(params[:amount])
	end

	def charge_a_card(params)
		card = fetch_a_card(params.fetch(:name,nil))
		if card == nil
			puts "User with that name was not found"
			return
		end
		card.charge(params[:amount])
	end

	def display_redundant_user_warning(user_name)
		puts invalid_user_message(user_name)
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