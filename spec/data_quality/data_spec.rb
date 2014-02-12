# Because we have so much test data we need to ensure that the test data itself does not accidentally get 
# Changed. This spec tests all of our test data and is a failsafe for data integrity.
require 'spec_helper'

# note that it is necessary to have the constants as strings
# here in order to avoid conflict with the other tests

describe "CC_NUMBERS" do

	it "should be a hash of valid credit card numbers" do
		CC_NUMBERS.should == {
    "American Express" => 378282246310005,
    "American Express 2" => 371449635398431,
    "American Express Corporate" => 378734493671000,
    "Australian BankCard" => 5610591081018250,
    "Diners Club" => 30569309025904,
    "Diners Club 2" => 38520000023237,
    "Discover" => 6011111111111117,
    "Discover 2" => 6011000990139424,
    "JCB" => 3530111333300000,
    "JCB 2" => 3566002020360505,
    "MasterCard" => 5555555555554444,
    "MasterCard 2" => 5105105105105100,
    "Visa" => 4111111111111111,
    "Visa 2" => 4012888888881881,
    "Visa 3" => 4222222222222,
    }
	end
end

describe "WELCOME_MESSAGE" do

	it "should be equal to the welcome message" do
		WELCOME_MESSAGE.should eq <<-String

		 Welcome to Braintree Jr.

		 You can choose from the following commands:
		
		 To create a new credit card use the following format: Add Tom 4111111111111111 $1000
		 To charge an existing credit card use the following format: Charge Tom $500
		 To credit an existing credit card use the following format: Credit Tom $500
		
		 When you are ready to see a summary of all inputs type 'done'
		 To display these commands again, type 'help'

     String
	end
end

describe "TEST_COMMAND_LINE_PROMPTS" do

	it "should be equal to the following hash" do
		TEST_COMMAND_LINE_PROMPTS.should == {"ADD wesley 4012888888881881 $10000" => {:name => "Wesley", :number => "4012888888881881", :limit => "$10000"},
			"credit jamie $100" => {:name=>"Jamie", :amount=>"$100"},
			"charge Shari $4400" => {:name=>"Shari", :amount=>"$4400"},
			"this is not a valid prompt" => "this is not a valid prompt"}
	end
end

describe "VALID_NEW_CARD" do

	it "should be equal to the following hash" do
		VALID_NEW_CARD.should == { :name=> "Miley",:number =>"4433099586883995", :limit => "$5000"}
	end
end

describe "TEST_SESSION_INFORMATION" do

	it "should be equal to the following hash" do
		TEST_SESSION_INFORMATION.should == [{:name =>"Andrew", :ballance => 33}, {:name =>"Joe", :ballance => 933}, {:name => "Tyson", :ballance => -400}]
	end
end

describe "TEST_FORMATTED_SESSION_INFO" do

	it "should be equal to the following array" do
		TEST_FORMATTED_SESSION_INFO.should == ["Andrew: $33\n", "Joe: $933\n", "Tyson: $-400\n"]
	end
end

describe "VALID_ADD_PROMPTS" do

	it "should be equal to the following array" do
		VALID_ADD_PROMPTS.should == ["ADD Wesley 4012888888881881 $10000",
										 "AdD Jennifer 5555555555554444 $1",
										 "add Nugen 5555555555554444 $55345",
										 "aDD David 5555555555554444 $100",
										 "Add bea323triz 83938475849302933 $6664",
										 "adD warren 4012888888881881 $4000" 
										]
	end
end

describe "INVALID_ADD_PROMPTS" do

	it "should be equal to the following array" do
		INVALID_ADD_PROMPTS.should == ["ADD3 Wesley 4012888888881881 $10000",
										 "AdD Jennifer D 12345678 $1",
										 "add Nugen 3949439848320 $55345 $3",
										 "aDD 894503450293454545 $100",
										 "Add $6664",
										 "adD warren ewer4012888888881881 $4000", 
										 "add wilco 5555555555554444 $ 4000",
										]
	end
end

describe "TEST_CHARGES" do

	it "should be equal to the following array" do
		TEST_CHARGES.should == ["charge Warren $00",
								"charge Wesley $55",
								"charGe Jennifer $1",	
								"charge nugen $2000",
								"charge david $94",
								"charge Bea323triz $999999"
							 ]
	end
end

describe "TEST_CREDITS" do

	it "should be equal to the following array" do
		TEST_CREDITS.should == ["credit Warren $20",
								"credit Wesley $110",
								"credit Jennifer $2",	
								"credit nugen $4000",
								"credit david $188",
								"credit Bea323triz $50"
							 ]
	end
end

describe "INVALID_USER_PROMPTS" do

	it "should be equal to the following array" do
		INVALID_USER_PROMPTS.should == ["salted pork",
												"the empire strikes back",
												"blake griffin vs justin bieber"
												]
	end
end

describe "TEST_NOT_FOUND_INFO" do

	it "should be equal to the following string" do
	TEST_NOT_FOUND_INFO.should eq "User tom does not exist. You must create a card for them first\n"
	end
end

describe "TEST_ALREADY_EXISTS_INFO" do

	it "should be equal to the following string" do
	TEST_ALREADY_EXISTS_INFO.should == "Sorry, but a user with the name of 'Tom' already exists. For now all users must have unique names\n"
	end
end

describe "BAD_AMOUNT" do

	it "should be equal to the following string" do
		BAD_AMOUNT.should eq "Limits and charge ammounts must start with a '$' sign and be followed by a valid whole number."
	end
end

describe "NAN" do

	it "should be equal to the following string" do
		NAN.should eq "That is not a valid number or it is more than 19 digits"
	end
end
