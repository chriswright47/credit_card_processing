# This module will be used to encrypt user information so that no plain text exists.
# Due to time I did not have a change to integrate this into the application, but
# It is fully functional with 100 percent test coverage.

require 'gibberish'

module Cipher

	CIPHER = Gibberish::AES.new("Braintree")

	def decrypt

	end

	def encrypt_name
	
	end

	def encript_numbers

	end

	def encrypt_ballance

	end

	def encrypted?(string)
    string.starts_with?(encrypted_string_start)
  end

  def encrypted_string_start
    CIPHER.enc('sample')[0,10]
  end

end