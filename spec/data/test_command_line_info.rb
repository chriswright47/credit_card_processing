TEST_COMMAND_LINE_PROMPTS = {

	"ADD Wesley 4012888888881881 $10000" => {:name => "Wesley", :number => "4012888888881881", :limit => "$10000"},
	"credit jamie $100" => {:name=>"jamie", :amount=>"$100"},
	"charge shari $4400" => {:name=>"shari", :amount=>"$4400"},
	"this is not a valid prompt" => "this is not a valid prompt"
}

TEST_SESSION_INFORMATION = [{:name =>"Andrew", :ballance => 33}, {:name =>"Joe", :ballance => 933}, {:name => "Tyson", :ballance => -400}]

TEST_FORMATTED_SESSION_INFO = ["Andrew: $33\n", "Joe: $933\n", "Tyson: $-400\n"]

TEST_CARD_PARAMS = {:name=> "Tyson", :number=>3530111333300000, :limit => "$4000"}

