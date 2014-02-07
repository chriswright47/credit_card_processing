require 'spec_helper'

include Luhn10

describe Luhn10 do

	context "Function takes the correct argument" do

		it "should require a Fixnum as its input" do
			expect { check_card("NAN") }.to raise_error
		end

		it "should only accept an argument that is at most 19 digits" do
			expect { check_card(12345678901234567890) }.to raise_error
		end
	end

	context "Invalid CC Numbers" do

		it "should return false if the credit card number is invalid" do
				CC_NUMBERS.each_pair do |number,value|
				check_card(value+1).should eq false
				end
		end
	end

		context "Valid CC Numbers" do

		it "should return true if the credit card number is valid " do
			CC_NUMBERS.each_pair do |number,value|
				check_card(value).should eq true
			end
		end
	end
end