require 'spec_helper'

describe CreditCard do

	context "Including Luhn10 module" do

		it "should include the Luhn10 module" do
			check_card(5555555555554444).should eq true
		end
	end

	context "Initialization" do

		it "Should take as inputs for initialization a [name, credit card number, and limit]" do
			tyson_card = CreditCard.new({:name => "Tyson", :number => 378282246310005, :limit => "$1000"})
			tyson_card.name.should eq "Tyson"
			tyson_card.number.should eq 378282246310005
			tyson_card.limit.should eq 1000
		end

		it "should require a [name, credit card number, and limit] in order to be initialized" do
			expect { CreditCard.new({:name => nil, :number => 101010101010101, :limit => "$4000"}) }.to raise_error
		end

		it "should be initialized with a balance of 0 if it is a valid card" do
			bryson_card = CreditCard.new({:name => "Bryson", :number => 38520000023237, :limit => "$8000"})
			bryson_card.balance.should eq 0
		end

		it "should be initialized with a balance value of 'error' if it is an invalid card" do
			jessica_card = CreditCard.new({:name => "Jessica", :number => 38523200423237, :limit => "$8340"})
			jessica_card.balance.should eq 'error'
		end

		it "should check to see if the card number is a valid number" do
			ellen_card = CreditCard.new({:name => "Ellen", :number => 378282246310005, :limit => "$20"})
			ellen_card.valid.should eq true
		end

		it "should check to see if the card number is an invalid number" do
			james_card = CreditCard.new({:name => "James", :number => 3782822463100051, :limit => "$9999000"})
			james_card.valid.should eq false
		end
	end

	context "instance methods" do

		context "charge" do

			it "should not increase the balance of an invalid card" do
				brittnay_card = CreditCard.new({:name => "Brittnay", :number => 321482246318888, :limit => "$8000"})
				brittnay_card.charge("$134")
				brittnay_card.charge("$1000")
				brittnay_card.balance.should eq 'error'
			end

			# As per the initial input specs you gave, we can change this easily enough later on if we like
			it "should not let you change a valid card an amount that is not a whole number" do
				jessica_card = CreditCard.new({:name => "Jessica", :number => 5610591081018250, :limit => "$4333"})
				expect { jessica_card.charge("$14.55") }.to raise_error
				jessica_card.balance.should eq 0
			end

			it "should increase the balance of a valid card by the amount indicated up to and including the limit" do
				joelle_card = CreditCard.new({:name => "Joelle", :number => 5610591081018250, :limit => "$3333"})
				joelle_card.charge("$3333")
				joelle_card.balance.should eq 3333
			end

			it "should not allow a valid card to be charged over the pre-established limit" do
				paolo_card = CreditCard.new({:name => "Paolo", :number => 3530111333300000, :limit => "$2000"})
				paolo_card.charge("$750")
				paolo_card.balance.should eq 750
				paolo_card.charge("$750")
				paolo_card.balance.should eq 1500
				paolo_card.charge("$750")
				paolo_card.balance.should eq 1500
			end
		end

		context "credit" do

			it "should not decrease the balance of an invalid card" do
				sophie_card = CreditCard.new({:name => "Sophie", :number => 4988457458457043, :limit => "$87943"})
				sophie_card.credit("$100")
				sophie_card.credit("3322")
				sophie_card.balance.should eq 'error'
			end

			it "should not let you credit a valid card with an amount that is not a whole number" do
				ian_card = CreditCard.new({:name => "Ian", :number => 4111111111111111, :limit => "$1212"})
				expect { ian_card.credit("$413.55") }.to raise_error
				ian_card.balance.should eq 0
			end

			it "should decrease the balance of a valid credit card by the indicated amount" do
				mufasa_card = CreditCard.new({:name => "Mufasa", :number => 4111111111111111, :limit => "$1212"})
				mufasa_card.credit("$10")
				mufasa_card.credit("$4958")
				mufasa_card.balance.should eq -4968
			end
		end
	end

	context "correct_params" do

		it "should return true if name, number and limit attributes are present" do
			jamie_card = CreditCard.new({:name => "Jamie", :number => 37478886310005, :limit => "$1"})
			(jamie_card.send :correct_params).should eq true
		end
	end

	context "format_ammount" do

		it "should require that the limit start with a dollar sign and be followed by a valid number" do
			expect { CreditCard.new({:name => "Bobby", :number => 374788863, :limit => "*12345"}) }.to raise_error
			expect { CreditCard.new({:name => "Robby", :number => 78834534863, :limit => "$$12345"}) }.to raise_error
			expect { CreditCard.new({:name => "Tony", :number => 374788863999000, :limit => "1$2345"}) }.to raise_error
			expect { CreditCard.new({:name => "Jobs", :number => 63999000, :limit => "$02345"}) }.to raise_error
		end

		it "should convert the argument string into a number" do
			heather_card = CreditCard.new({:name => "Heather", :number => 378282246310005, :limit => "$987654321"})
			heather_card.limit.should eq 987654321
		end
	end
end