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
			elsif command[0..3].downcase == "add "
				create_new_card(parse(command))
			elsif command[0..6].downcase == "credit "
				credit_a_card(parse(command))
			elsif command[0..6].downcase == "charge "
				charge_a_card(parse(command))
			else 
				display_error_message(command)
			end
			break if finished # This was necessary for rspec testing
			command = command_prompt
		end
		display_session_summary
	end


	def create_new_card(card_info)
		# this would be an invalid command with too many words
		return display_error_message(card_info) unless card_info.length == 3 
		# for now, we are not allowing users of the same name 
		return user_warning(card_info[:name]) if fetch_a_card(card_info[:name]) ## deal with getting this in the right format
		self.session_information << self.credit_card.new(card_info)
	end

	def fetch_a_card(card_owner)
		self.session_information.each do |element|
			return element if element.name == card_owner
		end
		nil
	end

	def credit_a_card(params)
		card = fetch_a_card(params.fetch(:name,nil))
		return display_error_message("Card not fount") unless card
		card.credit(params[:amount])
	end

	def charge_a_card(params)
		card = fetch_a_card(params.fetch(:name,nil))
		return display_error_message("Card not fount") unless card
		card.charge(params[:amount])
	end

	def user_warning(user_name)
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