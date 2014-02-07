module Luhn10
	def check_card(number)
		# Preventing bad inputs
		raise ArgumentError.new("Invalid Input: must be a number") unless number.is_a? Fixnum
		raise ArgumentError.new("Invalid Input: must be under 20 digits") if number.to_s.length > 19
		# Empty string container for our final number
		number_string = ""
		# Convert number to an array of reversed strings
		reversed_number_array = number.to_s.split("").reverse
		# Add each odd index number and each even index number*2 to our number_string
		reversed_number_array.each_with_index do |number, index|
			number_string<< number if index%2 == 0
			number_string<< (number.to_i*2).to_s if index%2==1
		end
		# We split the string, reduce it by summing each number with the previous number,
		# And check to see if the result mod 10 is equal to 0 is true
		number_string.split("").reduce(0) {|sum,num| sum+num.to_i}%10==0
	end
end

