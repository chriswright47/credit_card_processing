require 'spec_helper'

include Messages

describe Messages do

	context "welcome_message" do

		it "should return the welcome message" do
			welcome_message.should eq WELCOME_MESSAGE
		end
	end

	context "error_message" do

		it "should return an error message that changes depending on what the error was" do
			error_message("fake command").should eq set_error_message("fake command")
		end
	end

	context "session_summary_message" do

		it "should return an array containing the session summary information" do
			array_of_testing_ojects = []
			Testing = Struct.new(:name, :ballance)
			ty = Testing.new("tyson", 0)
			bill = Testing.new("bill", 440)
			array_of_testing_ojects << ty
			array_of_testing_ojects << bill
			session_summary_message(array_of_testing_ojects).should eq ["tyson: $0\n", "bill: $440\n"]
		end
	end

	context "invalid_user_message" do

		it "should return a string which says a user does not exist" do
			invalid_user_message("tom").should eq TEST_NOT_FOUND_INFO
		end
	end	

	context "user_already_exists_message" do

		it "should return a string which says a user does not exist" do
			user_already_exists_message("Tom").should eq TEST_ALREADY_EXISTS_INFO
		end
	end
end