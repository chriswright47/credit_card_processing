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
			
			it "should run until someone types in EXIT" do
				YoloClass = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(YoloClass)
			end

			it "should print out the welcome message if the user types in HELP" do

			end

			it "should print out all the user's credit card info and ballances if someone enters DONE" do

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