require 'spec_helper'

describe ApplicationUserInterface do
	
	before do
		@interface = ApplicationUserInterface.new(CreditCard)
	end

	context "Included Modules" do

		it "should include the Messages module" do
			@interface.welcome_message.should eq WELCOME_MESSAGE
		end

		it "should include the RuntimeUtils module" do
			@interface.parse("Hola").should eq "Hola"
		end
	end

	context "Initialization" do

		it "should be initialized with a credit card" do 
			expect { ApplicationUserInterface.new(CreditCard) }.not_to raise_error
			ApplicationUserInterface.new(CreditCard).credit_card.class.should eq Class
		end

		it "should create an empty session_information array upon Initialization" do
			@interface.session_information.should eq []
		end
	end

	context "Instance Methods" do

		context "run" do

			it "should call the session_driver method which is the driver for the application" do
				@interface.stub(:session_driver) {"Working"}
				expect(@interface.run).to eq "Working"
			end
		end

		context "session_driver" do

			# This was a tricky method to test, see the readme for my notes

			it "should print out the welcome message if the user input is help" do
				@interface.stub(:command_prompt) {"help"}
				@interface.stub(:finished) {true}
				@interface.stub(:display_valid_commands) { WELCOME_MESSAGE }
				@interface.stub(:display_session_summary) {@interface.send(:display_valid_commands)}
				@interface.run.should eq WELCOME_MESSAGE
			end

			it "should print out all the user's credit card info and ballances if the user enters 'done'" do
				@interface.stub(:command_prompt) {"done"}
				@interface.stub(:display_session_summary) {TEST_FORMATTED_SESSION_INFO}
				@interface.run.should eq TEST_FORMATTED_SESSION_INFO
			end

			it "should create a new credit card object if the user's first input word is 'add '" do
				VALID_ADD_PROMPTS.each do |prompt|
					@interface.stub(:command_prompt) {prompt}
					@interface.stub(:finished) {true}
					@interface.run
					@interface.session_information.each {|element| element.class.should eq CreditCard }
				end
			end

			it "should not create a new credit card object if the user's add input is incorrectly formatted" do
				INVALID_ADD_PROMPTS.each do |prompt|
					@interface.stub(:command_prompt) {prompt}
					@interface.stub(:finished) {true}
					@interface.run
					@interface.session_information.length.should eq 0
				end
			end

			# this can be changed easily, but I decided to do this for the MVP to save me some work
			it "should not create a new credit card object if a credit card object already exists for a user of that name" do
				2.times do
					VALID_ADD_PROMPTS.each do |prompt|
						@interface.stub(:command_prompt) {prompt}
						@interface.stub(:finished) {true}
						@interface.run
					end
				end
				@interface.session_information.length.should eq 6
			end

			it "should update the ballance of an existing card with a new charge if the first word is charge" do
				VALID_ADD_PROMPTS.each do |prompt|
					@interface.stub(:command_prompt) {prompt}
					@interface.stub(:finished) {true}
					@interface.run
				end
				TEST_CHARGES.each do |charge|
					@interface.stub(:command_prompt) {charge}
					@interface.stub(:finished) {true}
					@interface.run
				end
				@interface.session_information[0].ballance.should eq 55
				@interface.session_information[1].ballance.should eq 1
				@interface.session_information[2].ballance.should eq 2000
				@interface.session_information[3].ballance.should eq 94
				@interface.session_information[4].ballance.should eq "error"
				@interface.session_information[5].ballance.should eq 0
			end

			it "should return an error message if you try to charge a card that does not exist" do
				@interface.stub(:command_prompt) {"charge tom $1000"}
				@interface.stub(:finished) {true}
				@interface.stub(:display_invalid_user_message) {TEST_NOT_FOUND_INFO}
				@interface.stub(:display_session_summary) { @interface.send(:display_invalid_user_message) }
				@interface.run.should eq TEST_NOT_FOUND_INFO
				@interface.session_information.should eq []
			end

			it "should return an error message if you try to credit a card that does not exist" do
				@interface.stub(:command_prompt) {"credit tom $1000"}
				@interface.stub(:finished) {true}
				@interface.stub(:display_invalid_user_message) {TEST_NOT_FOUND_INFO}
				@interface.stub(:display_session_summary) { @interface.send(:display_invalid_user_message) }
				@interface.run.should eq TEST_NOT_FOUND_INFO
				@interface.session_information.should eq []
			end

			it "should update the ballance of an existing card with a new credit if the first word is credit" do
				VALID_ADD_PROMPTS.each do |prompt|
					@interface.stub(:command_prompt) {prompt}
					@interface.stub(:finished) {true}
					@interface.run
				end
				TEST_CREDITS.each do |charge|
					@interface.stub(:command_prompt) {charge}
					@interface.stub(:finished) {true}
					@interface.run
				end
				@interface.session_information[0].ballance.should eq -110
				@interface.session_information[1].ballance.should eq -2
				@interface.session_information[2].ballance.should eq -4000
				@interface.session_information[3].ballance.should eq -188
				@interface.session_information[4].ballance.should eq "error"
				@interface.session_information[5].ballance.should eq -20
			end

			it "should let the user know that the command they entered is not a valid input if that is the case" do
				INVALID_USER_PROMPTS.each do |prompt|
					@interface.stub(:command_prompt) {prompt}
					@interface.stub(:finished) {true}
					@interface.stub(:display_error_message) { set_error_message(prompt) }
					@interface.stub(:display_session_summary) { @interface.send(:display_error_message) }
					@interface.run.should eq set_error_message(prompt)
				end
			end
		end

		context "display_valid_commands" do

			it "should puts out a welcome message for the user" do
				@interface.stub(:puts) {WELCOME_MESSAGE}
				@interface.send(:display_valid_commands).should eq WELCOME_MESSAGE
			end
		end

		context "command_prompt" do

			it "should take a user's input" do
				@interface.stub(:gets).and_return("working")
				@interface.send(:command_prompt).should eq "working"
			end
		end

		context "create_new_card" do

			it "should create a new card if the user inputs a command in this format: Add Tom 4111111111111111 $1000" do
				@interface.send(:create_new_card, {name: "Tom", number: "4111111111111111", limit: "$1000"} )
				@interface.session_information[0].name.should eq "Tom"
				@interface.session_information[0].number.should eq "4111111111111111"
				@interface.session_information[0].limit.should eq 1000
				@interface.session_information[0].class.should eq CreditCard
			end

			it "should not create a card and display an error message if there is a user that aleady exists with the same name" do
				@interface.stub(:user_warning) {"Wrong"}
				@interface.send(:create_new_card, {name: "Tom", number: "4111111111111111", limit: "$1000"} )
				@interface.send(:create_new_card, {name: "Tom", number: "4111111111111111", limit: "$1000"} ).should eq "Wrong"
				@interface.session_information[0].class.should eq CreditCard
				@interface.session_information[1].should eq nil
			end

			it "should return from the function and display and error message if the card info is not correctly formatted" do
				@interface.stub(:display_error_message) {"Wrong"}
				@interface.send(:create_new_card, "Not at all formatted" ).should eq "Wrong"
			end

		end

		context "fetch_a_card" do
			it "should fetch the card of a user by name if that user exists" do
				VALID_ADD_PROMPTS.each do |prompt|
					@interface.stub(:command_prompt) {prompt}
					@interface.stub(:finished) {true}
					@interface.run
				end
				@interface.send(:fetch_a_card, "Wesley").name.should eq "Wesley"
				@interface.send(:fetch_a_card, "David").ballance.should eq 0
				@interface.send(:fetch_a_card, "Horatio").should eq nil
			end
		end

		context "credit_a_card" do

			it "should return from the method and display an error message if the credit params are incorrectly formatted" do
				@interface.stub(:display_error_message) {"Not a valid input"}
				@interface.send(:credit_a_card, "Jamie 1000").should eq "Not a valid input"
			end

			it "should return and display an error message if an attempted to credit a card that does not exist was made" do
				@interface.stub(:display_invalid_user_message) {"Not found"}
				@interface.send(:credit_a_card, {name: "Leslie", amount: "$1000"}).should eq "Not found"
			end

			it "should credit a valid existing card by the amount indicated" do
				@interface.stub(:command_prompt) {"Add sarah 5105105105105100 $1445"}
				@interface.stub(:finished) {true}
				@interface.run
				@interface.send(:credit_a_card, {name: "Sarah", amount: "$1000"})
				@interface.session_information[0].ballance.should eq -1000
			end
		end

		context "charge_a_card" do

			it "should return from the method and display an error message if the charge params are incorrectly formatted" do
				@interface.stub(:display_error_message) {"Not a valid input"}
				@interface.send(:charge_a_card, "Not formatted info").should eq "Not a valid input"
			end

			it "should return and display an error message if an attempted to charge a card that does not exist was made" do
				@interface.stub(:display_invalid_user_message) {"Not found"}
				@interface.send(:charge_a_card, {name: "Luna", amount: "$1000"}).should eq "Not found"
			end

			it "should charge a valid existing card by the amount indicated" do
				@interface.stub(:command_prompt) {"Add william 5105105105105100 $6000"}
				@interface.stub(:finished) {true}
				@interface.run
				@interface.send(:charge_a_card, {name: "William", amount: "$1000"})
				@interface.session_information[0].ballance.should eq 1000
			end
		end

		context "user_warning" do
			
			it "should display a warning to the user if there already exists a user of the same name" do
				@interface.stub(:puts) {"This user already exists"}
				@interface.send(:user_warning, "Leslie").should eq "This user already exists"
			end
		end

		context "correct_length" do

			it "should return true if the length of the params is equal to two" do
				@interface.send(:correct_length, ["one","two"]).should eq true
				@interface.send(:correct_length, ["only one thing here"]).should eq false

			end
		end

		context "correct_creation_params" do

			it "should return true if the length of the params is equal to three" do
				@interface.send(:correct_creation_params, ["one","two", "three"]).should eq true
				@interface.send(:correct_creation_params, ["only one thing here again"]).should eq false
			end
		end

		context "display_session_summary" do

			it "should display a summary of the session" do
				@interface.stub(:puts) {"Summary of the session"}
				@interface.send(:display_session_summary).should eq "Summary of the session"
			end
		end

		context "display_error_message" do
			
			it "should display an error message" do
				@interface.stub(:puts) {"An error message"}
				@interface.send(:display_error_message, "Error").should eq "An error message"
			end
		end

		context "display_invalid_user_message" do
			it "should display an error message" do
				@interface.stub(:puts) {"An error message"}
				@interface.send(:display_invalid_user_message, "Error").should eq "An error message"
			end
		end

		context "finished" do
			it "should do nothing - this is just an rspec helper" do
				@interface.send(:finished).should eq nil
			end
		end
	end
end
