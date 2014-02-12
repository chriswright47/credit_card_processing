# This is the credit card class which models credit card objects

class CreditCard
	# Luhn10 is the algorithm we are using to check to see if the card number is a valid card number 
	include Luhn10

	# This is included so that we can use its is_limit_valid? method to check the format of a limit/charge
	include RuntimeUtils

	# We need an accessor for ballance so that we can charge the card and see the ballance due
	attr_accessor :ballance

	# We need readers so that we can test attributes with Rspec
	attr_reader :name, :number, :limit, :valid
	
	def initialize(params)
		@name = params.fetch(:name,nil)
		@number = params.fetch(:number,nil)
		@valid = valid_card?(@number)
		@limit = format_amount(params.fetch(:limit))
		@valid ? @ballance = 0 : @ballance = "error"
		raise ArgumentError.new("Must be initialized with a name, number and limit") unless correct_params
	end

	# Return and do nothing if the card is not valid. Raise an error if the charge
	# Is not a whole amount - charges are whole amounts as per your specs. Then we
	# transform the amount into a number and add it to the balance of the card if
	# the charge amount plus current balance is less than the card's limit
	def charge(amount)
		return unless self.valid
		raise ArgumentError.new("Charges must be whole numbers") if amount=~/\./
		dollar_ammount = format_amount(amount)
		self.ballance+=dollar_ammount if self.ballance+dollar_ammount <= self.limit
	end

	# same logic as above except that we subtract the credit amount from the card's
	# balance no matter what the amount is.
	def credit(amount)
		return unless self.valid
		raise ArgumentError.new("Credits must be whole numbers") if amount=~/\./
		dollar_ammount = format_amount(amount)
		self.ballance-=dollar_ammount
	end

	private

	# just cheking to see that the card was initialized correctly
	def correct_params
		self.name != nil && self.number != nil && self.limit != nil
	end

	# check card is a method of the Luhn10 module which checks to see if the card number
	# is a valid number
	def valid_card?(number)
		check_card(number)
	end

	# here we check to see if the charge/credit/limit passed in is in a valid format, i.e. a number.
	# If it is we strip away the $ sign and turn the amount into a number.
	def format_amount(dollar_string)
		unless is_limit_valid?(dollar_string)
			raise ArgumentError.new("Dollar ammount must start with a '$' sign and be followed by a valid number")
		end
		dollar_string[1..-1].to_i
	end
	
end