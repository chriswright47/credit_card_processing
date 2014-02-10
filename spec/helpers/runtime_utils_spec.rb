require 'spec_helper'

include RuntimeUtils

describe RuntimeUtils do

	context "parse" do

		it "should return a hash which contains the correcty parsed information for a comand line entry" do

			COMMAND_LINE_PROMPTS.each_pair do |key, value|
				parse(key).should eq value
			end
		end
	end
end