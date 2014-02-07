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

			it "should return return nil after putsing out its string" do
				YoloClass = Struct.new(:name, :number, :limit)
				interface = ApplicationUserInterface.new(YoloClass)
				interface.display_valid_commands.should eq nil
			end
		end
	end
end