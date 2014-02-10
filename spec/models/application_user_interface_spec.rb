require 'spec_helper'

describe ApplicationUserInterface do

	context "Initialization" do

		it "should require a new class object as an argument" do
			YoloClass = Struct.new(:name, :number, :limit)
			expect { ApplicationUserInterface.new(YoloClass) }.not_to raise_error
			expect { ApplicationUserInterface.new("Hi") }.to raise_error
		end
	end

	context "Instance Methods" do

		context "display_valid_commands" do
			# display_valid_commands is just a wrapper method which puts out
			# the welcome_message from the Messages module. Here I am testing 
			# the message itself, which the string that the wrapper method uses.
			it "should puts out a welcome message for the user" do
				YoloClass = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(YoloClass)
				interface.welcome_message.should eq WELCOME_MESSAGE
			end
		end

		context "command_prompt" do

			it "should take a user's input" do

			end
		end

		context "run" do
			# This is a tricky method to test since it runs an an infinite loop.
			# At first I just stubbed out the command_prompt method with the corresponding
			# Keywords 


			it "should print out the welcome message" do
				YoloClass = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(YoloClass)
				interface.stub(:run) {WELCOME_MESSAGE}
				interface.run.should eq WELCOME_MESSAGE
			end

			it "should print out all the user's credit card info and ballances if someone enters 'done'" do
				YoloClass = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(YoloClass)
				interface.stub(:session_information) {[{:name =>"Andrew", :ballance => 33}, {:name =>"Joe", :ballance => 933}]}
				interface.session_summary_message(interface.session_information).should eq ["Andrew: $33\n", "Joe: $933\n"]
			end

			it "should create a new credit card object if the user's first input word is add" do

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