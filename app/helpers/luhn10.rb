# This module includes the check_card method used for validating valid credit cards

# This algorythem works as follows:
# As per the specifications we need to let the user know they entered bad inputs
# i.e. if the input number is not a number or if the number is greater than 19 digits.
# We then convert the 
# Convert number to an array of reversed strings
# Add each odd index number and each even index number*2 to our number_string
# We split the string, reduce it by summing each number with the previous number,
# And check to see if the result mod 10 is equal to 0 is true

module Luhn10
	def check_card(number)
		raise ArgumentError.new("Invalid Input: must be a valid number") if number.to_i == 0
		raise ArgumentError.new("Invalid Input: must be under 20 digits") if number.to_s.length > 19
		number_string = ""
		reversed_number_array = number.to_s.split("").reverse
		reversed_number_array.each_with_index do |number, index|
			number_string<< number if index%2 == 0
			number_string<< (number.to_i*2).to_s if index%2==1
		end
		number_string.split("").reduce(0) {|sum,num| sum+num.to_i}%10==0
	end
end

