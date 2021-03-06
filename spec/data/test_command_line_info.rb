# This is various test information that the specs use. This information itself is also tested
# in the data_spec, so don't change it.

TEST_COMMAND_LINE_PROMPTS = {

	"ADD wesley 4012888888881881 $10000" => {:name => "Wesley", :number => "4012888888881881", :limit => "$10000"},
	"credit jamie $100" => {:name=>"Jamie", :amount=>"$100"},
	"charge Shari $4400" => {:name=>"Shari", :amount=>"$4400"},
	"this is not a valid prompt" => "this is not a valid prompt"
}

SPLIT_TEST_COMMAND_LINE_PROMPTS = {["ADD", "wesley", "4012888888881881", "$10000"] => {:name => "Wesley", :number => "4012888888881881", :limit => "$10000"},
	["credit", "jamie", "$100"] => {:name=>"Jamie", :amount=>"$100"},
	["charge", "Shari", "$4400"] => {:name=>"Shari", :amount=>"$4400"},
	["this", "is", "not", "a", "valid", "prompt"] => {:name=>"Is", :amount=>"not"}
}

VALID_NEW_CARD = { :name=> "Miley",:number =>"4433099586883995", :limit => "$5000"}

TEST_SESSION_INFORMATION = [{:name =>"Andrew", :balance => 33}, {:name =>"Joe", :balance => 933}, {:name => "Tyson", :balance => -400}]

TEST_FORMATTED_SESSION_INFO = ["Andrew: $33\n", "Joe: $933\n", "Tyson: $-400\n"]

VALID_ADD_PROMPTS = ["ADD Wesley 4012888888881881 $10000",
										 "AdD Jennifer 5555555555554444 $1",
										 "add Nugen 5555555555554444 $55345",
										 "aDD David 5555555555554444 $100",
										 "Add bea323triz 83938475849302933 $6664",
										 "adD warren 4012888888881881 $4000"
										]

INVALID_ADD_PROMPTS = ["ADD3 Wesley 4012888888881881 $10000",
										 "AdD Jennifer D 12345678 $1",
										 "add Nugen 3949439848320 $55345 $3",
										 "aDD 894503450293454545 $100",
										 "Add $6664",
										 "adD warren ewer4012888888881881 $4000",
										 "add wilco 5555555555554444 $ 4000",
										]

TEST_CHARGES = ["charge Warren $00",
								"charge Wesley $55",
								"charGe Jennifer $1",
								"charge nugen $2000",
								"charge david $94",
								"charge Bea323triz $999999"
							 ]


TEST_CREDITS = ["credit Warren $20",
								"credit Wesley $110",
								"credit Jennifer $2",
								"credit nugen $4000",
								"credit david $188",
								"credit Bea323triz $50"
							 ]

INVALID_USER_PROMPTS = ["salted pork",
												"the empire strikes back",
												"blake griffin vs justin bieber"
												]

TEST_NOT_FOUND_INFO = "User tom does not exist. You must create a card for them first\n"

TEST_ALREADY_EXISTS_INFO = 	"Sorry, but a user with the name of 'Tom' already exists. For now all users must have unique names\n"

BAD_AMOUNT = "Limits and charge ammounts must start with a '$' sign and be followed by a valid whole number."

NAN = "That is not a valid number or it is more than 19 digits"

