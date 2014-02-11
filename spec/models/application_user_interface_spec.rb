require 'spec_helper'

describe ApplicationUserInterface do

	context "Initialization" do

		it "should" do 

		end
	end

	context "Instance Methods" do

		context "display_valid_commands" do
			# display_valid_commands is just a wrapper method which puts out
			# the welcome_message from the Messages module. Here I am testing 
			# the message itself, which the string that the wrapper method uses.
			it "should puts out a welcome message for the user" do
				TestCard = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(TestCard)
				interface.welcome_message.should eq WELCOME_MESSAGE
			end
		end

		context "command_prompt" do

			it "should take a user's input" do

			end
		end

		context "run" do

			# This was a tricky method to test, see the readme for my notes

			it "should print out the welcome message if the user input is help" do
				TestCard = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(TestCard)
				interface.stub(:command_prompt) {"help"}
				interface.stub(:finished) {true}
				interface.stub(:display_valid_commands) { WELCOME_MESSAGE }
				interface.stub(:display_session_summary) {interface.send(:display_valid_commands)}
				interface.run.should eq WELCOME_MESSAGE
			end

			it "should print out all the user's credit card info and ballances if the user enters 'done'" do
				TestCard = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(TestCard)
				interface.stub(:command_prompt) {"done"}
				interface.stub(:finished) {true}
				interface.stub(:display_session_summary) {TEST_FORMATTED_SESSION_INFO}
				interface.run.should eq TEST_FORMATTED_SESSION_INFO
			end

			it "should create a new credit card object if the user's first input word is 'add '" do
				interface = ApplicationUserInterface.new(CreditCard)
				interface.stub(:command_prompt) {"ADD wesley 4012888888881881 $10000"}
				interface.stub(:finished) {true}
				interface.run
				interface.session_information[0].class.should eq CreditCard
				interface.stub(:command_prompt) {"add Jennifer 418594354352 $500"}
				interface.stub(:finished) {true}
				interface.run
				interface.session_information[1].class.should eq CreditCard
			end

			it "should not create a new credit card object if the user's add input is incorrect " do
				interface = ApplicationUserInterface.new(CreditCard)
				interface.stub(:command_prompt) {"ADD 4012888888881881 $10000 "}
				interface.stub(:finished) {true}
				interface.run
				interface.session_information[0].class.should eq CreditCard
			end

			it "should update the ballance of the card with a new charge if the first word is charge" do

			end

			it "should update the ballance of the card with a new credit if the first word is credit" do

			end

			it "should let the user know that the command they entered is not a valid input if that is the case" do

			end
		end
	end
end