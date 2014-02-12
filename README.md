Took a TDD approach to this, discovering new things along the way. Encryption, decided to not use factory girl because in this situation it wouldent really help that much since I wanted a lot of controll over ... and would have to manually enter the credit card numbers and limits myself anyways

I read the instructions twice, went and looked up all of the relevant info about things I still didnt know

Started with orginizing my file layout with the necessary folders I would need

Started with the luhn10. I went and implemented couple different variations myself, then I went and
did research online as to...

from the luhn10 I went on to the actually credit_card class itsself

at this point I made a cipher module, but didn't implement it

then I went to the ui

A note about testing private methods -- yeah i know that this is typically frowned upon -- in this context I decided to test every line of code, since the application_user_interface class only has one method that is public and it would have been impossible to test the other methods otherwise. but I wanted to be extra sure.... some private methods, such as the session driver method absolutley needed to be tested. This being financial software I wanted to be sure everything worked correctly.

a lot of testing, using rspec, and when things were unclear as to how to tests - say stin/stout

I took a tdd approach to the code

If we get further in this process I know you guys are going to ask me to extend the code, so I took advantage of modules, and orginized my files in a way that will hopefully make it easy to add new features and functionality

Usually I would not test private methods, I would do tests that 

# The biggest challenge of writing this software was using a TDD approach
# In conjunction with Designing the ApplicationInterface class's 'run' method.
# This is a tricky method to test since it runs an an infinite loop, which does not 
# Play nicely with Rspec. I worked on testing this method for quite some time.
# Here is the simple original method:

	# def run 
	# 	display_valid_commands
	# 	command = command_prompt
	# 	until command.downcase == "done"
	# 		if command.downcase == "help"
	# 			display_valid_commands
	# 		elsif command[0..2].downcase == "add"
	# 			create_new_card(parse(command))
	# 		elsif command[0..5].downcase == "credit"
	# 			credit_a_card(parse(command))
	# 		elsif command[0..5].downcase == "charge"
	# 			charge_a_card(parse(command))
	# 		else 
	# 			display_error_message
	# 		end
	# 	command = command_prompt
	# 	end
	# 	display_session_summary
	# end

# At first I just stubbed out the command_prompt method with the corresponding
# Keywords - i.e. interface.stub(:command_prompt) {"help"} but this led to an infinite
# Loop which Rspec got stuck in. I then tried using threads to contain the run method
# i.e. - thread = Thread.new do
# interface.run.should.eq WELCOME_MESSAGE
# end
# thread.kill
# But this did not work since the contents of the block would not actually run.
# I then tried to take the contents of the thread block and add it to a variable in the
# Scope of the Rspec test itself, which works great in irb, but not in rspec:
# tmp =""
# thread = Thread.new do
# tmp+= interface.run # I was going to have this return a string
# end
# thread.kill
# I could not get tmp to update inside of the context of the thread block for some reason.
# At this point I considered revising the run method itself to make it more testable.
# I weighed the pros and cons of not having an infinite loop or adding functionality
# To the method that would allow me to make it more testable, but increase the
# Complexity of the method. I really wanted to stick to my TDD approach so I decided
# To refactor the method to work with Rspec at the cost of having another line of code:
	# break if finished
# And an extra empty method that I could stub out to be true using Rspec:
	# def finished
	# end


I tried to write this in a very modular way, which is why there are redundant raise exception ... and checks in the runtime utils module. So that the credit card class could be used elsewhere if you wanted to.
