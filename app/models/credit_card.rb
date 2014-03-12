# This is the credit card class which models credit card objects

class CreditCard
	# Luhn10 is the algorithm we are using to check to see if the card number is a valid card number 
	include Luhn10

	# This is included so that we can use its is_limit_valid? method to check the format of a limit/charge
	include RuntimeUtils

	attr_accessor :ballance

	attr_reader :name, :number, :limit, :valid
	
	def initialize(params)
		@name = params.fetch(:name,nil)
		@number = params.fetch(:number,nil)
		@valid = valid_card?(@number)
		@limit = format_amount(params.fetch(:limit))
		@valid ? @ballance = 0 : @ballance = "error"
		raise ArgumentError.new("Must be initialized with a name, number and limit") unless correct_params
	end


	def charge(amount)
		return unless self.valid
		raise ArgumentError.new("Charges must be whole numbers") if amount=~/\./
		dollar_ammount = format_amount(amount)
		self.ballance+=dollar_ammount if self.ballance+dollar_ammount <= self.limit
	end


	def credit(amount)
		return unless self.valid
		raise ArgumentError.new("Credits must be whole numbers") if amount=~/\./
		dollar_ammount = format_amount(amount)
		self.ballance-=dollar_ammount
	end

	private


	def correct_params
		self.name != nil && self.number != nil && self.limit != nil
	end


	def valid_card?(number)
		check_card(number)
	end


	def format_amount(dollar_string)
		unless is_limit_valid?(dollar_string)
			raise ArgumentError.new("Dollar ammount must start with a '$' sign and be followed by a valid number")
		end
		dollar_string[1..-1].to_i
	end
	
end