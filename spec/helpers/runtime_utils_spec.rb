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
		it "should return the correcty formatted information for creating new cards and charging/crediting them" do
			SPLIT_TEST_COMMAND_LINE_PROMPTS.each_pair do |key, value|
			format_info(key).should eq value
			end
		end
	end

	context "check_validity" do

		it "should" do

		end
	end
end