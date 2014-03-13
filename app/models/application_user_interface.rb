#This is the class that is in charge or running the application

class ApplicationUserInterface

	# this module contains all the raw messages to be displayed by the run method
	include Messages

	# this module contains all the helper methods, such as parse, for the run method
	include RuntimeUtils

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
			# this conditional branch seems ugly
			# if you can make the Card class itself responsible
			# for responding to the command,
			# e.g. Card.respond(command.downcase)
			# and then have all logic of parsing / responding to command
			# in Card class (no big deal as is, just not as O.O.)
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
		return display_error_message(card_info) unless correct_creation_params(card_info)
		return user_warning(card_info[:name]) if fetch_a_card(card_info[:name])
		self.session_information << self.credit_card.new(card_info)
	end


	def fetch_a_card(card_owner)
		self.session_information.each do |element|
			return element if element.name == card_owner
		end
		nil
	end


	def credit_a_card(params)
		return display_error_message(params) unless correct_length(params)
		card = fetch_a_card(params[:name].capitalize)
		return display_invalid_user_message(params[:name]) unless card
		card.credit(params[:amount])
	end


	def charge_a_card(params)
		return display_error_message(params) unless correct_length(params)
		card = fetch_a_card(params[:name].capitalize)
		return display_invalid_user_message(params[:name]) unless card
		card.charge(params[:amount])
	end


	def user_warning(user_name)
		puts user_already_exists_message(user_name)
	end


	def correct_length(params)
		params.length == 2
	end


	def correct_creation_params(params)
		params.length == 3
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


	def display_invalid_user_message(user_name)
		puts invalid_user_message(user_name)
	end


	#See my readme for an explination about this method
	def finished
	end


	def command_prompt
		print "Enter a command:"
		gets.chomp
	end

end