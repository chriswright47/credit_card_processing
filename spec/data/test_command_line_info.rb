TEST_COMMAND_LINE_PROMPTS = {

	"ADD Wesley 4012888888881881 $10000" => {:name => "Wesley", :number => "4012888888881881", :limit => "$10000"},
	"credit jamie $100" => {:name=>"jamie", :amount=>"$100"},
	"charge shari $4400" => {:name=>"shari", :amount=>"$4400"},
	"this is not a valid prompt" => "this is not a valid prompt"
}

TEST_SESSION_INFORMATION = [{:name =>"Andrew", :ballance => 33}, {:name =>"Joe", :ballance => 933}, {:name => "Tyson", :ballance => -400}]

TEST_FORMATTED_SESSION_INFO = ["Andrew: $33\n", "Joe: $933\n", "Tyson: $-400\n"]

TEST_CARD_PARAMS = {:name=> "Tyson", :number=>3530111333300000, :limit => "$4000"}

VALID_ADD_PROMPTS = ["ADD Wesley 4012888888881881 $10000",
										 "AdD Jennifer 5555555555554444 $1",
										 "add Nugen 5555555555554444 $55345",
										 "aDD David 5555555555554444 $100",
										 "Add bea323triz 83938475849302933 $6664",
										 "adD warren 4012888888881881 $4000", 
										]

INVALID_ADD_PROMPTS = ["ADD3 Wesley 4012888888881881 $10000",
										 "AdD Jennifer D 12345678 $1",
										 "add Nugen 3949439848320 $55345 $3",
										 "aDD 894503450293454545 $100",
										 "Add $6664",
										 "adD warren ewer4012888888881881 $4000", 
										 "add wilco 5555555555554444 $ 4000", 
										]

TEST_CHARGES = ["Charge Wesley $55",
								"charGe Jennifer $1",	
								"charge Nugen $2000",
								"charge David $94",
							 ]
TEST_BALLANCES = [55,1,2000,94,"error","error"]