#Disclaimer

- For some reason the code on github has 4 spaces for every indent. I am not quite sure why this is since my local machine looks fine with 2 spaces -- Just know that I did not do that on purpose.

#The Basics

- Running the application:
1. bundle
2. from root run ‘ruby app.rb’ to run the application
3. run ‘rake spec’ to run the specs (This app has 110 percent test coverage)

#Why I Picked Ruby

- Ruby is the language I know best and I really like its style, flexibility, and ‘magic’. I love writing in Ruby.

#Project Overview

With this project I took a pure TDD approach (using Rspec) and discovered many new things along the way. I started the project by reading the instructions you sent me twice, and then went and looked up all of the relevant info about things I still didn’t know – i.e. like what the Luhn10 algorithm was.

Once I had a pretty good grasp of what you wanted and the best way to go about it, I spend some time drawing up the design of the app – classes, responsibilities, testing strategies, etc. –and then got to work organizing my folder layout with the necessary folder and files I would need. 

When all the setup was finished I decided to start with the luhn10 algo. I went and implemented couple different variations myself, then I went and did some research online to see if I could find a more efficient solution. I settled on a hybrid of my solution and another one I thought was clever.

After writing the tests and the algo for the Luhn10, I moved on to the tests for the CreditCard class. At this point I realized that all the information we are storing in the session should be encrypted, so I went ahead and made a Cipher module. Rather then letting feature creep get the best of me, I decided to wait off until everything was done to encrypt the data.

In my tests for the CreditCard class I made the decision to not use FactoryGirl because it would not be a good fit for the nature of my tests – every credit card should be different in different situations. I ended up making up my own test data factories when needed instead.

After the CreditCard class was done I moved on the ApplicationInterface class and built out the UI. I built out a couple other modules I needed at this time – RuntimeUtils & Messages – really put a focus on keeping everything nice and modular. I know you guys are going to ask me to extend the code in some way and architecting my code like this will hopefully make it easy to add new features and functionality.

A note about testing private methods -- yeah I know that this is typically frowned upon – but in this context I decided to test every line of code, since the ApplicationInterface class only has one method that is/should be public and it would have been impossible to test all the private methods otherwise. Also, since this is financial software I wanted to be extra sure that everything worked correctly.

The biggest challenge of writing this software was using TDD in conjunction with designing the ApplicationInterface class's 'run' method. This is a tricky method to test since it runs as an infinite loop, which does not play nicely with Rspec. I worked on testing this method for quite some time. Here is the original method:

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

At first I just stubbed out the command_prompt method with the corresponding
keywords  I wanted to test- i.e. interface.stub(:command_prompt) {"help"} - but this led to an infinite loop which Rspec got stuck in. I then tried using threads to contain the run method i.e:

	# thread = Thread.new do
	# interface.run.should.eq WELCOME_MESSAGE
	# end
	# thread.kill

But this did not work since the contents of the block would not actually run in Rspec. I then tried to take the contents of the thread’s block and add it to a variable in the scope of the Rspec test itself, which works great in irb, but not in rspec:
	# tmp =""
	# thread = Thread.new do
	# tmp+= interface.run # I was going to have this return a string
	# end
	# thread.kill

I could not get tmp to update inside of the context of the thread block for some reason…

 At this point I considered revising the run method itself to make it more testable.
I weighed the pros and cons of not having an infinite loop and or adding functionality to the method that would allow me to make it more testable, but potentially increase the complexity of the method. I really wanted to stick to TDD and test everything so I decided to refactor the method to work with Rspec at the cost of having another line of code:

	# break if finished

And an extra empty method that I could stub out to be true using Rspec, which would break out of the loop:

	# def finished
	# end

When everything was done with the ApplicationInterface class I went back and refactored the RuntimeUtils module to be cleaner and have better public interfaces. When that was done I went ahead and created the app.rb file and ran the code for the first time. It worked as expected, but I decided to change around two of the error messages to be a little bit clearer. Actual human testing is just important as Rspec/Integration testing so I made sure to test out every possible situation by hand.

When everything was done with that I went ahead and looked at my list of extra features I wanted:

1. Package it as a gem for you
2. Encrypt the data using a gem like gibberish 

While both of these are important, I’ve got to get back to my other projects so they will have to be tabled for now.

Best -- Tyson Kunovsky

