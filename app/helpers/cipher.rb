# This module is used to encrypt user information

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