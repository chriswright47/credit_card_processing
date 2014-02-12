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

		context "session_driver" do

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
				interface.stub(:display_session_summary) {TEST_FORMATTED_SESSION_INFO}
				interface.run.should eq TEST_FORMATTED_SESSION_INFO
			end

			it "should create a new credit card object if the user's first input word is 'add '" do
				interface = ApplicationUserInterface.new(CreditCard)
				VALID_ADD_PROMPTS.each do |prompt|
					interface.stub(:command_prompt) {prompt}
					interface.stub(:finished) {true}
					interface.run
					interface.session_information.each {|element| element.class.should eq CreditCard }
				end
			end

			it "should not create a new credit card object if the user's add input is incorrectly formatted" do
				interface = ApplicationUserInterface.new(CreditCard)
				INVALID_ADD_PROMPTS.each do |prompt|
					interface.stub(:command_prompt) {prompt}
					interface.stub(:finished) {true}
					interface.run
					interface.session_information.length.should eq 0
				end
			end

			# this can be changed easily, but I decided to do this for the MVP to save me some work
			it "should not create a new credit card object if a credit card object already exists for a user of that name" do
				interface = ApplicationUserInterface.new(CreditCard)
				2.times do
					VALID_ADD_PROMPTS.each do |prompt|
						interface.stub(:command_prompt) {prompt}
						interface.stub(:finished) {true}
						interface.run
					end
				end
				interface.session_information.length.should eq 6
			end

			it "should update the ballance of an existing card with a new charge if the first word is charge" do
				interface = ApplicationUserInterface.new(CreditCard)
				VALID_ADD_PROMPTS.each do |prompt|
					interface.stub(:command_prompt) {prompt}
					interface.stub(:finished) {true}
					interface.run
				end
				TEST_CHARGES.each do |charge|
					interface.stub(:command_prompt) {charge}
					interface.stub(:finished) {true}
					interface.run
				end
				interface.session_information[0].ballance.should eq 55
				interface.session_information[1].ballance.should eq 1
				interface.session_information[2].ballance.should eq 2000
				interface.session_information[3].ballance.should eq 94
				interface.session_information[4].ballance.should eq "error"
				interface.session_information[5].ballance.should eq 0
			end

			it "should return an error message if you try to charge a card that does not exist" do
				interface = ApplicationUserInterface.new(CreditCard)
				interface.stub(:command_prompt) {"charge tom $1000"}
				interface.stub(:finished) {true}
				interface.stub(:charge_a_card) {"Card not found"}
				interface.stub(:display_session_summary) {interface.send(:charge_a_card)}
				interface.run.should eq "Card not found"
				interface.session_information.should eq []
			end

			it "should update the ballance of an existing card with a new credit if the first word is credit" do
				interface = ApplicationUserInterface.new(CreditCard)
				VALID_ADD_PROMPTS.each do |prompt|
					interface.stub(:command_prompt) {prompt}
					interface.stub(:finished) {true}
					interface.run
				end
				TEST_CREDITS.each do |charge|
					interface.stub(:command_prompt) {charge}
					interface.stub(:finished) {true}
					interface.run
				end
				interface.session_information[0].ballance.should eq -110
				interface.session_information[1].ballance.should eq -2
				interface.session_information[2].ballance.should eq -4000
				interface.session_information[3].ballance.should eq -188
				interface.session_information[4].ballance.should eq "error"
				interface.session_information[5].ballance.should eq -20
			end

			it "should let the user know that the command they entered is not a valid input if that is the case" do
				interface = ApplicationUserInterface.new(CreditCard)
				INVALID_USER_PROMPTS.each do |prompt|
					interface.stub(:command_prompt) {prompt}
					interface.stub(:finished) {true}
					interface.stub(:display_error_message) { set_error_message(prompt) }
					interface.stub(:display_session_summary) { interface.send(:display_error_message) }
					interface.run.should eq set_error_message(prompt)
				end
			end
		end

		context do

		end
		#let the user know that the user does not exist
	end
end
