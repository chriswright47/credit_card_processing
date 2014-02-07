class CreditCard

	include Luhn10

	# We need an accessor for ballance so that we can charge the card and see the ballance due
	attr_accessor :ballance

	# We need readers so that we can test attributes with Rspec
	attr_reader :name, :number, :limit, :valid
	

	def initialize(params)
		@name = params.fetch(:name,nil)
		@number = params.fetch(:number,nil)
		@valid = valid_card?(@number)
		@limit = format_amount(params.fetch(:limit))
		@ballance = 0
		raise ArgumentError.new("Must be initialized with a name, number and limit") unless correct_params
		# encrypt all data
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
		if dollar_string[0] != '$' || dollar_string[1].to_i == 0
			raise ArgumentError.new("Dollar ammount must start with a '$' sign and be followed by a valid number")
		end
		dollar_string[1..-1].to_i
	end
end