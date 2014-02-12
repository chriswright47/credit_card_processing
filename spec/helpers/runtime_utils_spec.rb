require 'spec_helper'

include RuntimeUtils

describe RuntimeUtils do

	context "Constants" do

		it "should have a CARD_CREATION_INFO constant that never changes" do
			CARD_CREATION_INFO.should eq [:name, :number, :limit]
		end

		it "should have a CARD_TRANSACTION_INFO constant that never changes" do
			CARD_TRANSACTION_INFO.should eq [:name, :amount]
		end
	end

	context "parse" do

		it "should return a hash which contains the correcty parsed information for a comand line entry" do
			TEST_COMMAND_LINE_PROMPTS.each_pair do |key, value|
				parse(key).should eq value
			end
		end
	end

	context "format_info" do
		it "should return the correcty formatted information for adding new cards and charging/crediting them" do
			SPLIT_TEST_COMMAND_LINE_PROMPTS.each_pair do |key, value|
			format_info(key).should eq value
			end
		end
	end

	context "check_validity" do

		it "should return an error if the limit/credit/charge amount is not valid -i.e. $01000" do
			check_validity({:name => "Ty", :limit => "$0112"}).should eq BAD_AMOUNT
		end

		it "should return an error if the someone adds a credit card with a number that is not a real number - i.e 823nfgb2323" do
			check_validity({ :name=> "Jonny",:number =>"444jnfr393828h", :limit => "$33333"}).should eq NAN
			check_validity({ :name=> "Jonny",:number =>"s44frffw328h", :limit => "$43333"}).should eq NAN
		end

		it "should return the original argument hash if both of the above conditions are satisfied" do
			check_validity({ :name=> "Miley",:number =>"4433099586883995", :limit => "$5000"}).should eq VALID_NEW_CARD
		end
	end

	context "invalid_number?" do

		it "should check to see if the length of the number passed in converted to_i is the same as the length of the original number" do
			invalid_number?("123456789").should eq false
			invalid_number?("123456789e").should eq true
			invalid_number?("w123456789").should eq true
		end
	end

	context "is_limit_valid?" do

		it "should check to see if the credit card limit/credit/charge amount is valid & correctly formatted" do
			is_limit_valid?("$1444f").should eq false
			is_limit_valid?("$01444").should eq false
			is_limit_valid?("$1444").should eq true
		end
	end

	context "shift_and_capitalize" do

		it "should remove the first element of the array and then capitalize the new first element" do
			shift_and_capitalize(["bye-bye", "jOnNy"]).should eq ["Jonny"]
		end
	end
	
	context "too_big_or_small?" do
		it "should check to see that the length of an array is either 3 or 4 elements" do
			too_big_or_small?(["1"]).should eq true
			too_big_or_small?(["1","2"]).should eq true
			too_big_or_small?(["1","2","3"]).should eq false
			too_big_or_small?(["1","2","3","4"]).should eq false
			too_big_or_small?(["1","2","3","4","5"]).should eq true
		end
	end

	context "is_this_add_card_info?" do

		it "should return true if the length of the argument passed in is == to 3" do
			is_this_add_card_info?(["1","2","3"]).should eq true
			is_this_add_card_info?(["1","2"]).should eq false
			is_this_add_card_info?(["1","2","3","4"]).should eq false
		end
	end

end